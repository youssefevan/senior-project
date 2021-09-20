extends "res://state_machine.gd"

func _ready():
	add_state("idle")
	add_state("run")
	add_state("jump")
	add_state("fall")
	call_deferred("set_state", states.idle)

func _input(event):
	
	if event.is_action_pressed("jump"):
		parent.jumpWasPressed = true
		parent.rememberJumpTime()
		if parent.canCoyoteJump == true:
			parent.velocity.y = -parent.JUMP_FORCE
	
	# minimum jump height (variable jump heigth)
	if state == states.jump:
		if Input.is_action_just_released("jump") && (parent.velocity.y < -parent.MIN_JUMP_HEIGHT):
			parent.velocity.y = -parent.MIN_JUMP_HEIGHT
	

func state_logic(delta):
	parent.handle_move_input(delta)
	parent.apply_gravity(delta)
	parent.apply_movement()
	
	#print(state)
	
	# If grounded
	if [states.idle, states.run].has(state):
		parent.emit_signal("grounded")
		# change friction and acceleration
		parent.accel = parent.GROUND_ACCEL
		parent.fric = parent.GROUND_FRIC
		
		# ready coyote jump
		parent.canCoyoteJump = true
		
		# if jump was pressed (phantom jump)
		if parent.jumpWasPressed == true:
			# allow player to jump
			parent.velocity.y = -parent.JUMP_FORCE
	
	# sprite flipping
	if state == states.run:
		if parent.velocity.x >= 20:
			parent.sprite.flip_h = false
		if parent.velocity.x <= -20:
			parent.sprite.flip_h = true
	
	# signal for blaster position
	if parent.sprite.flip_h == true:
		parent.emit_signal("flipped")
	if parent.sprite.flip_h == false:
		parent.emit_signal("not_flipped")
	
	# If not grounded
	if [states.jump, states.fall].has(state):
		parent.emit_signal("not_grounded")
		# change fric and accel
		parent.accel = parent.AIR_ACCEL
		parent.fric = parent.AIR_FRIC
		
		# if fall speed is greater than max fall speed
		if parent.velocity.y > parent.MAX_FALL_SPEED:
			parent.velocity.y = parent.MAX_FALL_SPEED
		
		# run coyote time
		parent.coyoteTime()
	
	# If not grounded, increase gravity
	if state == states.fall:
		if parent.velocity.y > 0:
			parent.grav = parent.DOWN_GRAV
		else:
			parent.grav = parent.GRAV
	
	#animation
	if state == states.fall:
		parent.animator.play("fall")
	if state == states.jump:
		parent.animator.play("jump")
	if state == states.run:
		parent.animator.play("run")
	if state == states.idle:
		parent.animator.play("idle")

func get_transition(delta):
	match state:
		states.idle:
			#print(state)
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x >= 20 || parent.velocity.x <= -20:
				return states.run
		states.run:
			#print(state)
			if !parent.is_on_floor():
				if parent.velocity.y < 0:
					return states.jump
				elif parent.velocity.y > 0:
					return states.fall
			elif parent.velocity.x < 20 && parent.velocity.x > -20:
				return states.idle
		states.jump:
			#print(state)
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y >= 0:
				return states.fall
		states.fall:
			#print(state)
			if parent.is_on_floor():
				return states.idle
			elif parent.velocity.y < 0:
				return states.jump
	return null

func enter_state(new_state, old_state):
	match new_state:
		states.idle:
			pass
		states.run:
			pass
		states.jump:
			pass
		states.fall:
			pass

func exit_state(old_state, new_state):
	pass
