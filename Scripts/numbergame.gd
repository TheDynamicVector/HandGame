extends Node2D

const P2coords = [-483,-195]
const P1coords = [485,-198]

var rng = RandomNumberGenerator.new()
var number1 = 0
var number2 = 0
var newRound = true

var numberSpawn1 = null
var numberSpawn2 = null
var p1score = 0
var p2score = 0

func _process(delta):
	if newRound:
		$p1score.text = "SCORE:" + str(p1score)
		$p2score.text = "SCORE:" + str(p2score)
		number1 = rng.randi_range(0,5)
		number2 = rng.randi_range(0,5)
		var number_prefab1 = load("res://Nodes/" + str(number1)+".tscn").duplicate()
		var number_prefab2 = load("res://Nodes/" + str(number2)+".tscn").duplicate()
		
		numberSpawn1 = number_prefab1.instantiate()
		numberSpawn2 = number_prefab2.instantiate()
		add_child.call_deferred(numberSpawn1)
		add_child.call_deferred(numberSpawn2)
		
		numberSpawn1.position.x = P1coords[0]
		numberSpawn1.position.y = P1coords[1]
		numberSpawn2.position.x = P2coords[0]
		numberSpawn2.position.y = P2coords[1]

		newRound = false
	

		
		
