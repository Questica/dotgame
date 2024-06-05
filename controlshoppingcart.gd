extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE
@onready var first_level_path = FILE_BEGIN + str(1) + FILE_TYPE
@onready var fallingbox = preload("res://fallingboxes.tscn")

var red = 255
var green = 255
var blue = 255
var alpha = 255
var cartreturn : bool
var finished : bool = false

func _ready():
	%LevelNumber.text = str(current_scene_file.to_int())
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
	var correctcolor = Color8(255, 0, 0, 255)
	var currentcolor = $"../CharacterBody2D/ColorRect".color
	if currentcolor == correctcolor and not finished:
		$"../BoxTimer".stop()
		$"../MouseTimer".start()
		$"../CharacterBody2D/TextureRect/Area2D".monitoring = false
		finished = true

func _on_button_pressed() -> void:
	if cartreturn:
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file(first_level_path)
	print(next_level_path)

func generate_boxes():
	var box = fallingbox.instantiate()
	add_child(box)

func _on_box_timer_timeout() -> void:
	generate_boxes()

func _on_area_2d_body_entered(body: Node2D) -> void:
	var group = body.get_groups()

	if body.is_in_group("red"):
		green -= 5
		blue -= 5
		$"../CharacterBody2D/ColorRect".color = Color8(red, green, blue, alpha)
		body.queue_free()
	elif body.is_in_group("wrong"):
		green = 255
		blue = 255
		$"../CharacterBody2D/ColorRect".color = Color8(red, green, blue, alpha)
		body.queue_free()

func _on_floor_body_entered(body: Node2D) -> void:
	if body.is_in_group("red") or body.is_in_group("wrong"):
		body.queue_free()

func _on_mouse_timer_timeout() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"../CharacterBody2D/Button".show()
	$CartReturnTexture.show()

func _on_return_area_area_entered(area: Area2D) -> void:
	cartreturn = true

func _on_return_area_area_exited(area: Area2D) -> void:
	cartreturn = false
