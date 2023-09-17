extends Node2D

var level_speed = 1.0

func _process(delta):
	
	var children = get_children()
	
	for i in children:
		
		i.position.y += level_speed
		
		if i.position.y >= 380:
			
			var levelpre = load("res://Nodes/Frogger"+["0", "1", "2", "3"].pick_random()+".tscn").duplicate()
		
			var lvl = levelpre.instantiate()
			add_child.call_deferred(lvl)
			
			i.queue_free()
			
			lvl.position.y -= 380



func _on_speed_up_timer_timeout():
	level_speed *= 1.3
	get_parent().get_node("SpeedUpTimer").wait_time *= 0.75
