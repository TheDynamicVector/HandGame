extends Node

var player_1_score = 0
var player_2_score = 0

var player_1_gesture = ""
var player_2_gesture = ""


var game_started = false

var gesture_texts = ["none", "none"]

var game = "numbergame"

var default_scene = "numbergame"

func _ready():
	new_level()
	await get_tree().create_timer(1).timeout
	gameInitialize

var possibleNumbers = ['zero','one','two','three','four','five']
var gameInitialize = false
func _process(_delta):
	
	gesture_texts = FileAccess.open("res://GestureData.txt", FileAccess.READ).get_as_text().split(",")
	#print(gesture_text)
	
	if game == "goose" and gesture_texts.size() == 2:
		
		if gesture_texts[0] == "zero":
			$/root/dinosaurgame/Goose1.jump()
			
		if gesture_texts[1] == "zero":
			$/root/dinosaurgame/Goose2.jump()
	
	if game == 'numbergame' and gesture_texts.size() == 2 and gameInitialize: 
		if gesture_texts[0] == possibleNumbers[$/root/numbergame.number]:
			$root/numbegame.newRound = true
		if gesture_texts[1] == possibleNumbers[$/root/numbergame.number]:
			$root/numbegame.newRound = true
			
			
		

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

	get_tree().change_scene_to_file("res://Levels/"+default_scene+".tscn")
	get_tree().reload_current_scene()
	WinRoundUi.visible = false
	get_tree().paused = false
