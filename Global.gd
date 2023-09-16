extends Node

var player_1_score = 0
var player_2_score = 0

var player_1_gesture = ""
var player_2_gesture = ""

var game_started = false

func _process(delta):
	
	if game_started:
		var gestures = []
		OS.execute("python", ["/handrecognition.py"], gestures)
		
		player_1_gesture = gestures[0]
