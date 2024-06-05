extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE
@onready var first_level_path = FILE_BEGIN + str(1) + FILE_TYPE

func _ready():
	%LevelNumber.text = str(current_scene_file.to_int())

func _on_button_pressed():
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)


func _on_button_2_pressed():
	get_tree().change_scene_to_file(first_level_path)
