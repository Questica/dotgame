extends CharacterBody2D


const SPEED = 7500.0
const BOUNCE = 0.8

func _ready() -> void:
	velocity = Vector2(-1,1).normalized() * SPEED

func _physics_process(delta: float) -> void:
	
	velocity.y += randi_range(-SPEED, SPEED) * delta
	velocity.x += randi_range(-SPEED, SPEED) * delta
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal()) * BOUNCE

func _process(delta):
	print(str(velocity.y))
