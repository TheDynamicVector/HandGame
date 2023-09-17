extends Area2D
var rng = RandomNumberGenerator.new()
var frozen = false

var SPEED = 3
const direction = -1
func _physics_process(_delta):
	
	if not frozen:
		position.x += direction * SPEED
	if position.x < -100:
		position.x = 600
		if not frozen:
			frozen = true
			await get_tree().create_timer(randi()%3).timeout
			SPEED += 0.33
			frozen = false
		
	


func _on_body_entered(body):
	if body.is_in_group('Player1'):
		Global.end_round(1)
	elif body.is_in_group('Player2'):
		Global.end_round(2)
