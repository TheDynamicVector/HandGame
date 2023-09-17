extends Area2D
var rng = RandomNumberGenerator.new()
var frozen = false

const SPEED = 3
const direction = -1
func _physics_process(delta):
	
	if not frozen:
		position.x += direction * SPEED

	if position.x < -60:
		position.x = 600
		if not frozen:
			frozen = true
			await get_tree().create_timer(randi()%3).timeout
			frozen = false
		

func _on_area_2d_body_entered(body):
	if body.is_in_group('Player1'):
		print('Player 2 won')
		
	elif body.is_in_group('Player2'):
		
		print("Player 1 won")
