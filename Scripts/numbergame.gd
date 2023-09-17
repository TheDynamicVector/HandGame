extends Node2D

const P1coords = [-483,-195]
const P2coords = [485,-198]

var rng = RandomNumberGenerator.new()
@export var number = 0
var newRound = 0
func _ready():
	newRound = true
	if newRound:
		number = rng.randf_range(0,5)
		var number_prefab = load("res://Nodes/" + str(number)+".tscn").duplicate()
		
		var numberSpawn1 = number_prefab.instantiate()
		var numberSpawn2 = number_prefab.instantiate()
		add_child.call_deferred(numberSpawn1)
		add_child.call_deferred(numberSpawn2)
		
		numberSpawn1.position = P1coords
		numberSpawn2.position = P2coords

		newRound = false
		

		
		
