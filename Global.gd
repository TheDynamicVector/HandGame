extends Node

var player_1_score = -1
var player_2_score = 0

var player_1_gesture = ""
var player_2_gesture = ""


var game_started = false

var gesture_texts = ["none", "none"]

var game = ""

var all_games = ["frogger", "dinasaur", "numbers"]

func _process(_delta):
	
	gesture_texts = FileAccess.open("res://GestureData.txt", FileAccess.READ).get_as_text().split(",")
	#print(gesture_text)
	
	if game == "goose" and gesture_texts.size() == 2:
		
		if gesture_texts[0] == "zero":
			$/root/dinosaurgame/Goose1.jump()
			
		if gesture_texts[1] == "zero":
			$/root/dinosaurgame/Goose2.jump()

func end_round(player_won):
	
	get_tree().paused = true
	WinRoundUi.visible = true
	
	if player_won == 1:
		player_1_score += 1
		if player_1_score == 3:
			pass
	else:
		player_2_score += 1
		if player_2_score == 3:
			pass

func new_level():

	game = all_games.pick_random()
	all_games.pop_at(all_games.find(game))
	get_tree().change_scene_to_file("res://Levels/"+game+".tscn")
	WinRoundUi.visible = false
	get_tree().paused = false
