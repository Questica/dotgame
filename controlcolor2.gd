extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE
@onready var current_level_path = FILE_BEGIN + str(current_scene_file.to_int()) + FILE_TYPE

func _ready():
	%LevelNumber.text = str(current_scene_file.to_int())

func _on_button_pressed():
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)

func _on_timer_timeout() -> void:
	$"../VBoxContainer/Hint".show()

func _on_hint_pressed() -> void:
	$"../VBoxContainer/ValuesLabel".show()
	$"../VBoxContainer/Hint".hide()
