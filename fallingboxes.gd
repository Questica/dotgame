extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var random = randi_range(1, 2)
	var position = randi_range(0, 1112)
	var rotation = randi_range(0, 360)
	$".".position = Vector2(position, -40)
	$".".set_rotation_degrees(rotation)
	if random == 1:
		$ColorRect.color = Color8(255,0,0,255)
		add_to_group("red")
	if random == 2:
		var red : int = randi_range(105, 220)
		var green : int = randi_range(105, 220)
		var blue : int = randi_range(105, 220)
		var alpha: int = randi_range(155, 240)
		$ColorRect.color = Color8(red, green, blue, alpha)
		add_to_group("wrong")
