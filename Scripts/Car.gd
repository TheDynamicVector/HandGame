extends Area2D
var rng = RandomNumberGenerator.new()

var SPEED = 6 + randf_range(-2,2)
@export var bound_original = 600
@export var bound = -100

@export var direction = -1

func _physics_process(_delta):
	
	position.x += direction * SPEED
	if position.x < bound:
		position.x = bound_original
		

func _on_body_entered(body):
	if body.is_in_group('Player1'):
		Global.end_round(1)
	elif body.is_in_group('Player2'):
		Global.end_round(2)
