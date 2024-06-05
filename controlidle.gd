extends Control

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE

var red : int = 0
var green : int = 255
var blue : int = 255
var alpha : int = 15
var dot : bool = false
var clickable : bool = false

func _ready():
	%LevelNumber.text = str(current_scene_file.to_int())

func _process(delta: float) -> void:
	update_labels()
	update_dot()

func _on_button_pressed():
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)

func update_labels():
	$Values/RedValue.text = str(red)
	$Values/GreenValue.text = str(green)
	$Values/BlueValue.text = str(blue)
	$Values/AlphaValue.text = str(alpha)
	if dot:
		$Values/DotValue.text = "yes"
		$"../ColorRect2".show()
	if not dot:
		$Values/DotValue.text = "no"
		$"../ColorRect2".hide()
	if clickable:
		$Values/ClickableValue.text = "yes"
		$Button.disabled = false
	if not clickable:
		$Values/ClickableValue.text = "no"
		$Button.disabled = true

func update_dot():
	$"../ColorRect2".color = Color8(red, green, blue, alpha)
	var target_color = Color8(255, 0, 0, 255)
	var current_color = $"../ColorRect2".color
	if target_color == current_color:
		clickable = true

func _on_alpha_timer_timeout() -> void:
	if alpha < 255:
		alpha += 1

func _on_alpha_timer_2_timeout() -> void:
	if alpha < 255:
		alpha += 1

func _on_blue_timer_timeout() -> void:
	if blue > 0:
		blue -= 1

func _on_green_timer_timeout() -> void:
	if green > 0:
		green -= 1

func _on_cyan_timer_timeout() -> void:
	if blue > 0:
		blue -= 1
	if green > 0:
		green -= 1

func _on_red_timer_timeout() -> void:
	if red < 255:
		red += 1

func _on_pink_timer_timeout() -> void:
	if alpha < 255:
		alpha += 1
	if red < 255:
		red += 1

func _on_dot_button_pressed() -> void:
	if alpha >= 5:
		alpha -= 5
		dot = true
		$Panel/MarginContainer/VBoxContainer/DotButton.queue_free()
		$Panel/MarginContainer/VBoxContainer/BlueRemoverButton.show()
		$Panel/MarginContainer/VBoxContainer/GreenRemoverButton.show()
		$Panel/MarginContainer/VBoxContainer/CyanRemoverButton.show()
		$Panel/MarginContainer/VBoxContainer/RedAdderButton.show()
		$Panel/MarginContainer/VBoxContainer/PinkAdderButton.show()

func _on_alpha_adder_button_pressed() -> void:
	if alpha >= 15:
		alpha -= 15
		$"../AlphaTimer2".start()
		$AlphaAdderIcon.show()
		$Panel/MarginContainer/VBoxContainer/AlphaButtonButton.show()
		$Panel/MarginContainer/VBoxContainer/AlphaAdderButton.queue_free()


func _on_alpha_button_button_pressed() -> void:
	if alpha >= 10:
		alpha -= 10
		$"../Panel".show()
		$"../Panel/MarginContainer/GridContainer/AlphaButton".show()
		$Panel/MarginContainer/VBoxContainer/AlphaButtonButton.queue_free()


func _on_blue_remover_button_pressed() -> void:
	if alpha >= 35:
		alpha-= 35
		$"../BlueTimer".start()
		$BlueRemoverIcon.show()
		$Panel/MarginContainer/VBoxContainer/BlueButtonButton.show()
		$Panel/MarginContainer/VBoxContainer/BlueRemoverButton.queue_free()


func _on_green_remover_button_pressed() -> void:
		if alpha >= 45:
			alpha-= 45
			$"../GreenTimer".start()
			$GreenRemoverIcon.show()
			$Panel/MarginContainer/VBoxContainer/GreenButtonButton.show()
			$Panel/MarginContainer/VBoxContainer/GreenRemoverButton.queue_free()


func _on_cyan_remover_button_pressed() -> void:
		if alpha >= 85:
			alpha-= 85
			$"../CyanTimer".start()
			$CyanRemoverIcon.show()
			$Panel/MarginContainer/VBoxContainer/CyanButtonButton.show()
			$Panel/MarginContainer/VBoxContainer/CyanRemoverButton.queue_free()


func _on_blue_button_button_pressed() -> void:
	if alpha >= 30:
		alpha -= 30
		$"../Panel".show()
		$"../Panel/MarginContainer/GridContainer/BlueButton".show()
		$Panel/MarginContainer/VBoxContainer/BlueButtonButton.queue_free()


func _on_green_button_button_pressed() -> void:
	if alpha >= 40:
		alpha -= 40
		$"../Panel".show()
		$"../Panel/MarginContainer/GridContainer/GreenButton".show()
		$Panel/MarginContainer/VBoxContainer/GreenButtonButton.queue_free()


func _on_cyan_button_button_pressed() -> void:
	if alpha >= 80:
		alpha -= 80
		$"../Panel".show()
		$"../Panel/MarginContainer/GridContainer/CyanButton".show()
		$Panel/MarginContainer/VBoxContainer/CyanButtonButton.queue_free()


func _on_red_adder_button_pressed() -> void:
	if alpha >= 105:
		alpha-= 105
		$"../RedTimer".start()
		$RedAdderIcon.show()
		$Panel/MarginContainer/VBoxContainer/RedButtonButton.show()
		$Panel/MarginContainer/VBoxContainer/RedAdderButton.queue_free()


func _on_red_button_button_pressed() -> void:
	if alpha >= 90:
		alpha -= 90
		$"../Panel".show()
		$"../Panel/MarginContainer/GridContainer/RedButton".show()
		$Panel/MarginContainer/VBoxContainer/RedButtonButton.queue_free()


func _on_pink_adder_button_pressed() -> void:
	if alpha >= 135:
		alpha-= 135
		$"../PinkTimer".start()
		$PinkAdderIcon.show()
		$Panel/MarginContainer/VBoxContainer/PinkButtonButton.show()
		$Panel/MarginContainer/VBoxContainer/PinkAdderButton.queue_free()


func _on_pink_button_button_pressed() -> void:
	if alpha >= 100:
		alpha -= 100
		$"../Panel".show()
		$"../Panel/MarginContainer/GridContainer/PinkButton".show()
		$Panel/MarginContainer/VBoxContainer/PinkButtonButton.queue_free()


func _on_alpha_button_pressed() -> void:
	alpha = min(alpha + 3, 255)


func _on_blue_button_pressed() -> void:
	blue = max(blue - 3, 0)


func _on_green_button_pressed() -> void:
	green = max(green - 3, 0)


func _on_cyan_button_pressed() -> void:
	blue = max(blue - 3, 0)
	green = max(green - 3, 0)

func _on_red_button_pressed() -> void:
	red = min(red + 3, 255)


func _on_pink_button_pressed() -> void:
	alpha = min(alpha + 3, 255)
	red = min(red + 3, 255)
