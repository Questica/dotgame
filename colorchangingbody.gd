extends CharacterBody2D

const SPEED = 255.0

var red : int = randi_range(105, 220)
var green : int = randi_range(105, 220)
var blue : int = randi_range(105, 220)
var alpha: int = randi_range(155, 240)

var addition
var subtraction

func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2(SPEED, 0)
		if addition and alpha in range(0, 255):
			alpha += 1
		if subtraction and alpha in range(1, 256):
			alpha -= 1
	elif Input.is_action_pressed("ui_left"):
		velocity = Vector2(-SPEED, 0)
		if addition and red in range(0, 255):
			red += 1
		if subtraction and red in range(1, 256):
			red -= 1
	elif Input.is_action_pressed("ui_up"):
		velocity = Vector2(0, -SPEED)
		if addition and blue in range(0, 255):
			blue += 1
		if subtraction and blue in range(1, 256):
			blue -= 1
	elif Input.is_action_pressed("ui_down"):
		velocity = Vector2(0, SPEED)
		if addition and green in range(0, 255):
			green += 1
		if subtraction and green in range(1, 256):
			green -= 1
	else:
		velocity = Vector2(0, 0)
	update_box()
	update_mode()
	move_and_slide()
	print(red, " ", green, " ", blue, " ", alpha)

func update_box():
	$ColorRect2.color = Color8(red, green, blue, alpha)
	var specific_color = Color8(255, 0, 0, 255)
	var current_color = $ColorRect2.color
	if current_color == specific_color:
		$Button.disabled = false
	else:
		$Button.disabled = true

func _on_area_2d_body_entered(body: Node2D) -> void:
	subtraction = true
	addition = false

func _on_area_2d_2_body_entered(body: Node2D) -> void:
	addition = true
	subtraction = false

func update_mode():
	if not addition and not subtraction:
		$"../VBoxContainer/ModeLabel".text = "mode:"
	elif addition:
		$"../VBoxContainer/ModeLabel".text = "mode: addition"
	elif subtraction:
		$"../VBoxContainer/ModeLabel".text = "mode: subtraction"
	$"../VBoxContainer/ValuesLabel".text = "(%s, %s, %s, %s)" % [red, green, blue, alpha]

func _on_reset_pressed() -> void:
	red = randi_range(105, 220)
	green = randi_range(105, 220)
	blue = randi_range(105, 220)
	alpha = randi_range(155, 240)
	#$ColorRect2.global_position = Vector2(556, 304)
