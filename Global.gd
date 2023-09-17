extends Node

var player_1_score = -1
var player_2_score = 0

var player_1_gesture = ""
var player_2_gesture = ""


var game_started = false

var gesture_texts = ["none", "none"]

var game = ""

var ready_ind_on = false

func _ready():
	await get_tree().create_timer(1).timeout
	gameInitialize = true
	
var all_games = ["frogger", "dinosaurgame", "numbersgame"]
var game_list = all_games

var possibleNumbers = ['zero','one','two','three','four','five']
var gameInitialize = false
var cooldownP1 = false
var cooldownP2 = false
func _process(_delta):
	
	gesture_texts = FileAccess.open("res://GestureData.txt", FileAccess.READ).get_as_text().split(",")
	#print(gesture_text)
	
	
	if game == "dinosaurgame" and gesture_texts.size() == 2:
		
		if gesture_texts[0] == "zero":
			$/root/dinosaurgame/Goose1.jump()
			
		if gesture_texts[1] == "zero":
			$/root/dinosaurgame/Goose2.jump()
	
	if game == 'numbersgame' and gesture_texts.size() == 2 and gameInitialize: 
		
		var numbersgameparent = $/root/numbersgame
		if gesture_texts[0] == possibleNumbers[numbersgameparent.number1] and not cooldownP1:
			numbersgameparent.numberSpawn1.queue_free()
			numbersgameparent.numberSpawn2.queue_free()
			numbersgameparent.p1score += 1
			if not cooldownP1:
				cooldownP1 = true
				cooldownP1 = false
			numbersgameparent.newRound = true

			
		if gesture_texts[1] == possibleNumbers[numbersgameparent.number2] and not cooldownP2:
			numbersgameparent.numberSpawn1.queue_free()
			numbersgameparent.numberSpawn2.queue_free()
			numbersgameparent.p2score += 1
			if not cooldownP2:
				cooldownP2 = true
				cooldownP1 = false
			numbersgameparent.newRound = true
			
			
		
			
	if game == "frogger" and gesture_texts.size() == 2:
		
		if gesture_texts[0] == "zero":
			$/root/frogger/Bird2.speed = $/root/frogger/BGS.level_speed
		elif gesture_texts[0] == "five":
			$/root/frogger/Bird2.speed = -1
			
		if gesture_texts[1] == "zero":
			$/root/frogger/Bird1.speed = $/root/frogger/BGS.level_speed
		elif gesture_texts[1] == "five":
			$/root/frogger/Bird1.speed = -1

func end_round(player_won):
	
	get_tree().paused = true
	WinRoundUi.visible = true
	
	WinRoundUi.get_node("WinText").text = "player " + str(player_won) + " won"
	
	if player_won == 1:
		player_1_score += 1
	else:
		player_2_score += 1

func new_level():

	if game_list == []:
		
		var winning_player = 1
		if player_2_score > player_1_score:
			winning_player = 2
		
		get_tree().change_scene_to_file("res://Levels/End.tscn")
		await get_tree().create_timer(1).timeout
		$/root/End/Results.text = "Player " + str(winning_player) + " WON!"
		return
		
	game = game_list.pick_random()
	game_list.pop_at(game_list.find(game))
	get_tree().change_scene_to_file("res://Levels/"+game+".tscn")
	WinRoundUi.visible = false
	get_tree().paused = false

func reset_game():
	
	game_list = all_games
	player_1_score = 0
	player_2_score = 0
	new_level()
