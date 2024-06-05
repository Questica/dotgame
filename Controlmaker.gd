extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE
@onready var first_level_path = FILE_BEGIN + str(1) + FILE_TYPE

var red : bool = false
var mouse : bool = false
var hover : bool = false

func _ready():
	%LevelNumber.text = str(current_scene_file.to_int())
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	mouse = false
	$LineEdit2.placeholder_text = str(current_scene_file.to_int())

func _on_button_pressed():
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)

func _on_line_edit_2_text_submitted(new_text):
	var background_array = ["background", "black"]
	var level_array = ["level", "number", "score", str(current_scene_file.to_int())]
	var mouse_array = ["mouse", "cursor", "pointer"]
	if new_text == 'text':
		$LineEdit2.hide()
		var timer := Timer.new()
		add_child(timer)
		timer.wait_time = 15.0
		timer.one_shot = true
		timer.start()
		timer.timeout.connect(on_timer_timeout)
	elif new_text in background_array:
		if $"../ColorRect".visible:
			$"../ColorRect".hide()
		else:
			$"../ColorRect".show()
	elif new_text == 'red dot':
		if $"../ColorRect2".visible and red:
			$"../ColorRect2".color = Color(255,255,255)
			$"../ColorRect2".hide()
			red = false
		elif not $"../ColorRect2".visible and not red:
			$"../ColorRect2".show()
			$"../ColorRect2".color = Color(255,0,0)
			red = true
		elif $"../ColorRect2".visible and not red:
			$"../ColorRect2".hide()
			$"../ColorRect2".color = Color(255,0,0)
			red = true
		elif not $"../ColorRect2".visible and red:
			$"../ColorRect2".show()
			$"../ColorRect2".color = Color(255,255,255)
			red = false
	elif new_text == 'dot':
		if $"../ColorRect2".visible:
			$"../ColorRect2".hide()
		else:
			$"../ColorRect2".show()
	elif new_text in level_array:
		if %LevelNumber.visible:
			%LevelNumber.hide()
			$LineEdit2.placeholder_text = str(current_scene_file.to_int())
		else:
			%LevelNumber.show()
			$LineEdit2.placeholder_text = ""
	elif new_text == 'red':
		if not red:
			$"../ColorRect2".color = Color(255, 0, 0)
			red = true
		elif red:
			$"../ColorRect2".color = Color(255, 255, 255)
			red = false
	elif new_text in mouse_array:
		if mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			mouse = false
		elif not mouse:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			mouse = true
	elif new_text == 'click' and $"../ColorRect2".visible and %LevelNumber.visible and red and hover:
		_on_button_pressed()
	$LineEdit2.clear()
	#if $"../ColorRect2".visible and %LevelNumber.visible and red:
			#$Button.show()
			#$Button.disabled = false

func on_timer_timeout():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$"../SoftLockWarning".show()
	$"../SoftLockButton".show()
	$"../SoftLockButton".disabled = false
	$"../SoftLockRestart".show()

func _on_soft_lock_button_pressed() -> void:
	get_tree().change_scene_to_file(first_level_path)

func _on_area_2d_mouse_entered() -> void:
	hover = true

func _on_area_2d_mouse_exited() -> void:
	hover = false
