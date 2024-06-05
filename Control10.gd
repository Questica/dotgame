extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE

var red : int
var blue : int
var green : int
var alpha : int

func _ready():
	%LevelNumber.text = str(current_scene_file.to_int())
	$"../ColorRect2".visible = false
	$Button.disabled = true
	$HBoxContainer/VSlider.visible = false
	$HBoxContainer/VSlider2.visible = false
	$HBoxContainer/VSlider3.visible = false
	$HBoxContainer/VSlider4.visible = false

func _on_button_pressed():
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)

func _on_check_button_toggled(toggled_on):
	if toggled_on:
		$"../ColorRect2".visible = true
		$HBoxContainer/VSlider.visible = true
		$HBoxContainer/VSlider2.visible = true
		$HBoxContainer/VSlider3.visible = true
		$HBoxContainer/VSlider4.visible = true
		$HBoxContainer/VSlider.value = randi_range(0, 255)
		$HBoxContainer/VSlider2.value = randi_range(0, 255)
		$HBoxContainer/VSlider3.value = randi_range(0, 255)
	else:
		$"../ColorRect2".visible = false
		$HBoxContainer/VSlider.visible = false
		$HBoxContainer/VSlider2.visible = false
		$HBoxContainer/VSlider3.visible = false
		$HBoxContainer/VSlider4.visible = false

func _on_v_slider_value_changed(value):
	red = int(value)
	update_color()

func _on_v_slider_2_value_changed(value):
	blue = int(value)
	update_color()

func _on_v_slider_3_value_changed(value):
	green = int(value)
	update_color()

func _on_v_slider_4_value_changed(value):
	alpha = int(value)
	update_color()

func update_color():
	var color = Color8(red, blue, green, alpha)
	$"../ColorRect2".color = color
	check_color()

func check_color():
	var specific_color = Color8(255, 0, 0, 255)
	var current_color = $"../ColorRect2".color
	if current_color == specific_color:
		$Button.disabled = false
	else:
		$Button.disabled = true
