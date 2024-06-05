extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

var moving : bool = false

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE
@onready var first_level_path = FILE_BEGIN + str(1) + FILE_TYPE

func _ready():
	$"../CharacterBody2D/Button".disabled = true
	%LevelNumber.text = str(current_scene_file.to_int())
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_button_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)


func _on_start_timer_timeout() -> void:
	moving = true

func _on_stop_timer_timeout() -> void:
	moving = false
	$"../CharacterBody2D/Button".disabled = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_button_10_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_11_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_12_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_13_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_4_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_5_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_6_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_button_7_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
