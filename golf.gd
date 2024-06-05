extends Node2D

const MAX_DISTANCE: float = 100.0

var mouse_position: Vector2 = Vector2.ZERO
var is_mouse_down := false
var start_color: Color = Color(1, 1, 1)
var end_color: Color = Color(1, 0, 0)
var current_color: Color = start_color
var mouse_pos1: Vector2 = Vector2.ZERO
var mouse_pos2: Vector2 = Vector2.ZERO
@onready var ball = $Ball
var end_point: Vector2 = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				is_mouse_down = true
				mouse_position = get_local_mouse_position()
				mouse_pos1 = get_local_mouse_position()
			else:
				is_mouse_down = false
				mouse_pos2 = get_local_mouse_position()
				print(mouse_pos1, mouse_pos2)
				mouse_released()
	elif event is InputEventMouseMotion and is_mouse_down:
		mouse_position = get_local_mouse_position()
		queue_redraw()

func _draw():
	if is_mouse_down:
		end_point = mouse_position
		var distance = ball.position.distance_to(end_point)
		
		if distance > MAX_DISTANCE:
			var direction = (end_point - ball.position).normalized()
			end_point = ball.position + direction * MAX_DISTANCE
			distance = MAX_DISTANCE

		# Calculate the proportion of distance (0 to 100 mapped to 0.0 to 1.0)
		var distance_ratio = distance / MAX_DISTANCE

		# Interpolate the color based on the distance ratio
		current_color = start_color.lerp(end_color, distance_ratio)
		
		# Draw the line with the current interpolated color
		draw_line(ball.position, end_point, current_color, 6)

func _process(delta):
	# Request a redraw to ensure _draw() is called each frame
	if is_mouse_down:
		queue_redraw()

func mouse_released():
	if mouse_pos1 != Vector2.ZERO and mouse_pos2 != Vector2.ZERO:
		var release_point = mouse_pos2
		var distance = mouse_pos1.distance_to(release_point)
		
		# Calculate direction from mouse_pos1 to mouse_pos2
		var direction = (release_point - mouse_pos1).normalized()
		
		# Cap the distance if needed
		if distance > MAX_DISTANCE:
			distance = MAX_DISTANCE
		
		# Apply force based on the distance and direction
		var force = direction * distance * 3
		
		ball.apply_impulse(Vector2(-force.x, -force.y))
		
		queue_redraw()
