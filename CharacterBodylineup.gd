extends CharacterBody2D


const SPEED = 1500.0
const BOUNCE = 0.97
@onready var moving = $"../Control".moving

func _ready() -> void:
	velocity = Vector2(-1,1).normalized() * randi_range(-SPEED, SPEED)

func _physics_process(delta: float) -> void:
	if moving:
		velocity.y += randi_range(-SPEED, SPEED) * delta
		velocity.x += randi_range(-SPEED, SPEED) * delta
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal()) * BOUNCE

func _process(delta):
	get_moving()

func get_moving():
	moving = $"../Control".moving
