extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"
const InputResponse = preload("res://response.tscn")
const Response = preload("res://responses.tscn")

@export var max_lines_remembered := 6

@onready var command_processor = $CommandProcessor
@onready var history_rows = $PanelContainer/MarginContainer/VBoxContainer/GameInfo/Scroll/History
@onready var scroll = $PanelContainer/MarginContainer/VBoxContainer/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE

func _ready() -> void:
	scrollbar.connect("changed", self.handle_scrollbar_changed)
	$PanelContainer/MarginContainer/VBoxContainer/GameInfo/Scroll.get_v_scroll_bar().set_scale(Vector2(0, 0))
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	var input_response = InputResponse.instantiate()
	var starting_message = "Type 'help' to see available commands."
	input_response.set_text(starting_message,"")
	add_response(input_response)

func handle_scrollbar_changed():
	scroll.scroll_vertical = scrollbar.max_value

func _on_line_edit_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	
	%LineEdit.clear()
	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)
	add_response(input_response)

func add_response(response: Control):
	history_rows.add_child(response)
	delete_history()

func delete_history():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
