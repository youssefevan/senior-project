extends "res://scripts/state-machine.gd"

func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func state_logic(delta):
	parent.get_input()
	parent.apply_gravity(delta)
	parent.apply_movement(delta)
	parent.facing()
	parent.camera_setup()

func get_transitions(delta):
	match state:
		states.idle:
			if parent.is_grounded != true:
				if !parent.motion.y > 0:
					return states.jump
				elif !parent.motion.y < 0:
					return states.fall
			elif parent.motion.x != 0:
				return states.run
		
		states.run:
			if parent.is_grounded != true:
				if !parent.motion.y > 0:
					return states.jump
				elif !parent.motion.y < 0:
					return states.fall
			elif parent.motion.x == 0:
				return states.idle
		
		states.jump:
			if parent.is_grounded == true:
				return states.idle
			elif parent.motion.x >= 0:
				return states.fall
		
		states.fall:
			if parent.is_grounded == true:
				return states.idle
			elif parent.motion.x < 0:
				return states.jump
	
	return null

func enter_state(new_state, old_state):
	match new_state:
		states.idle:
			parent.animator.play("idle")
			if parent.facing_left == true:
				parent.sprite.flip_h = true
			elif parent.facing_left != true:
				parent.sprite.flip_h = false
			
		states.run:
			if parent.facing_left == true:
				parent.sprite.flip_h = true
				if parent.motion.x > 0:
					parent.animator.play("walk_backwards")
			elif parent.facing_left != true:
				parent.sprite.flip_h = false
				if parent.motion.x < 0:
					parent.animator.play("walk")
			
		states.jump:
			parent.animator.play("jump")
			if parent.facing_left == true:
				parent.sprite.flip_h = true
			elif parent.facing_left != true:
				parent.sprite.flip_h = false
		
		states.fall:
			parent.animator.play("fall")
			if parent.facing_left == true:
				parent.sprite.flip_h = true
			elif parent.facing_left != true:
				parent.sprite.flip_h = false
