extends Sprite2D

var score := [0, 0]
const PADDLE_SPEED : int = 480
const PADDLE_SPEED_ENEMY : int = 420
const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"

@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE
@onready var first_level_path = FILE_BEGIN + str(1) + FILE_TYPE

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	score[0] = (current_scene_file.to_int())
	$HUD/PlayerScore.text = str(score[0])
	$Ball/Button.disabled = true
	$Ball/ColorRect.color = Color(255, 255, 255)

func _on_ball_timer_timeout():
	$Ball.new_ball()

func _on_score_left_body_entered(body):
	score[1] += 1
	$HUD/CPUScore.text = str(score[1])
	$BallTimer.start()
	if score[1] > 2:
		get_tree().change_scene_to_file(first_level_path)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_score_right_body_entered(body):
	$Ball/Button.disabled = false
	$Ball/ColorRect.color = Color(255, 0, 0)
	$BallTimer.start()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)


func _on_button_pressed():
	get_tree().change_scene_to_file(next_level_path)
	print(next_level_path)
