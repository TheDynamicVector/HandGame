extends Node

var player_1_score = 0
var player_2_score = 0

var player_gestures = ["", ""]

var current_game = "goose"

func _process(delta):
	
	var player_gestures = FileAccess.open("res://GestureData.txt", FileAccess.READ).get_as_text().split(",")
	
	if current_game == "goose" and player_gestures.size() == 2:
		
		if player_gestures[0] == "zero":
			$/root/dinosaurgame/Goose1.jump()
		elif player_gestures[1] == "zero":
			$/root/dinosaurgame/Goose2.jump()
