extends CharacterBody2D


const SPEED = 300.0
const direction = -1
func _physics_process(delta):
	velocity.x = direction * SPEED
	if position.x < -43:
		position.x = 530
	move_and_slide()


