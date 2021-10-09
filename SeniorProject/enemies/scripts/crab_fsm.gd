extends "res://state_machine.gd"

func _ready():
	add_state("idle")
	add_state("hostile")
	call_deferred("set_state", states.idle)

func _process(delta):
	print(parent.player_detected)
	print(parent.target_pos)
	if parent.player_detected == true:
		parent.target_pos = parent.target.global_position
		
		if (parent.target_pos.x - parent.position.x) > 0:
			parent.dir_x = 1
		elif (parent.target_pos.x - parent.position.x) <= 0:
			parent.dir_x = -1
		
		parent.velocity.x = parent.speed * parent.dir_x
		
	else:
		parent.sleep()

func state_logic(delta):
	parent.apply_gravity(delta)
	parent.apply_movement()

func get_transition(delta):
	match state:
		states.idle:
			#print(state)
			if parent.velocity.x != 0:
				return states.hostile
			
		states.hostile:
			#print(state)
			if parent.velocity.x == 0:
				return states.idle
			
	return null

func enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		states.hostile:
			pass

func exit_state(old_state, new_state):
	pass
