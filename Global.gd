extends Node

var player_1_score = 0
var player_2_score = 0

var player_1_gesture = ""
var player_2_gesture = ""


var game_started = false


var output = []

var player_1_gestures = []
var player_2_gestiures = []

func _ready():

	OS.execute("python", ["/handrecognition.py"], output)


func _process(delta):
	
	var gesture_text = FileAccess.open("res://GestureData.txt", FileAccess.READ).get_as_text()
	print(gesture_text)
	
