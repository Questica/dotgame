extends CharacterBody2D

var boxspeed : int = 300

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -=  boxspeed * delta
	elif Input.is_action_pressed("ui_right"):
		position.x +=  boxspeed * delta
	elif Input.is_action_pressed("ui_up"):
		position.y -=  boxspeed * delta
	elif Input.is_action_pressed("ui_down"):
		position.y +=  boxspeed * delta
	move_and_slide()
