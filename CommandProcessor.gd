extends Node

var itch : bool = false
var game : bool = false
var dot : bool = false
var test : bool = true

const FILE_BEGIN = "res://levels/level_"
const FILE_TYPE = ".tscn"
@onready var current_scene_file = get_tree().current_scene.scene_file_path
@onready var next_level_number = current_scene_file.to_int() + 1
@onready var next_level_path = FILE_BEGIN + str(next_level_number) + FILE_TYPE

func process_command(input: String):
	var words = input.split(" ", false)
	if words.size() == 0:
		return "You have to say something."
		
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
		
	match first_word:
		"go":
			return go(second_word)
		"look":
			return look()
		"help":
			return help()
		"click":
			return click(second_word)
		_:
			return "I don't know what you mean."

func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
	var itch_array = ["itch", "itchio", "itch.io"]
	if second_word in itch_array:
		itch = true
		return "You go to itch.io"
	var game_array = ["game", "dot", "red", "questhodgson.itch.io/reddotgame", "reddotgame", "reddot", "dotgame"]
	if second_word in game_array:
		game = true
		itch = false
		return "You go to questhodgson.itch.io/reddotgame"
	return "No."

func help() -> String:
	return """You can use these commands:
		 help
		 look
		 go [site]
		 click [thing]"""

func look() -> String:
	if not itch and not game and not dot:
		return "You are on level %s. You look around the room, you are in front of a computer, a web browser is open. There doesn't appear to be anything else useful." % str(current_scene_file.to_int()) 
	if itch:
		return "You look at the itch website. Maybe you can play a game."
	if game:
		return "You are looking at the red.game page. You see a run game button."
	if dot:
		return "You see a red dot."
	return "No."

func click(second_word: String) -> String:
	if second_word =="":
		return "Click what?"
	var run_array = ["run", "game", "button"]
	if game and second_word in run_array:
		game = false
		dot = true
		return "You click run game."
	var dot_array = ["red", "dot"]
	if dot and second_word in dot_array:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().change_scene_to_file(next_level_path)
		print(next_level_path)
		return "Click."
	return "No."
