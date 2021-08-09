extends KinematicBody2D

signal grounded_update(is_grounded)
signal large_y_limits()

const GROUND_ACCEL = 850
const AIR_ACCEL = 425
const MAX_SPEED = 85
const GROUND_FRIC = .1
const AIR_FRIC = .01
const GRAV = 600
const DOWN_GRAV = 1400
const JUMP_FORCE = 200
const MIN_JUMP_HEIGHT = 90
const MAX_FALL_SPEED = 250

var grav = 0
var accel = 0
var fric = 0
var motion = Vector2.ZERO
var canPhantomJump = true
var jumpWasPressed = false
var x_input = 0
var is_grounded
var room_size = Vector2.ZERO
var health = 10

func get_x_input():
	x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")

func apply_gravity(delta):
	motion.y += grav * delta

func _process(delta):
	
	get_x_input()
	apply_gravity(delta)
	health_check()
	animate()
	
	if x_input != 0:
		motion.x += x_input * accel * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, fric)
	
	if is_on_floor():
		accel = GROUND_ACCEL
		fric = GROUND_FRIC
		canPhantomJump = true
		if jumpWasPressed == true:
			motion.y = -JUMP_FORCE
	else:
		accel = AIR_ACCEL
		fric = AIR_FRIC
	
	if Input.is_action_just_pressed("jump"):
		jumpWasPressed = true
		rememberJumpTime()
		if canPhantomJump == true:
			motion.y = -JUMP_FORCE
	
	if motion.y > 0:
		grav = DOWN_GRAV
	else:
		grav = GRAV
	
	if !is_on_floor():
		coyoteTime()
	
	if Input.is_action_just_released("ui_up") and motion.y < -MIN_JUMP_HEIGHT:
		motion.y = -MIN_JUMP_HEIGHT
	
	var was_grounded = is_grounded
	is_grounded = is_on_floor()
	
	if was_grounded == null || is_grounded != was_grounded:
		emit_signal("grounded_update", is_grounded)
	
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if room_size.y > 72:
		emit_signal("large_y_limits")
	
	motion = move_and_slide(motion, Vector2.UP)

func coyoteTime():
	yield(get_tree().create_timer(.07), "timeout")
	canPhantomJump = false

func rememberJumpTime():
	yield(get_tree().create_timer(.075), "timeout")
	jumpWasPressed = false

func health_check():
	print(health)
	if health <= 0:
		die()

func die():
	pass

func _on_cameraroomdetection_area_entered(area):
	if area.get_collision_layer() == 16:
		room_size = area.global_scale * 2
		
		var cam = $camera
		cam.limit_top = area.global_position.y - room_size.y/2
		cam.limit_left = area.global_position.x - room_size.x/2
		cam.limit_bottom = cam.limit_top + room_size.y
		cam.limit_right = cam.limit_left + room_size.x

func animate():
	#print(motion.x)
	if get_local_mouse_position().x < 0:
		$sprite.flip_h = true
	elif get_global_mouse_position().x >= 0:
		$sprite.flip_h = false
	
	if is_grounded == true:
		#if moving right on the ground
		if motion.x >= 20:
			#and is facing forwards
			if $sprite.flip_h == false:
				$animator.play("walk")
			#and is facing backwards
			elif $sprite.flip_h == true:
				$animator.play("walk_backwards")
		#if moving left on the ground
		if motion.x <= -20:
			#and is facing forwards
			if $sprite.flip_h == false:
				$animator.play("walk_backwards")
			#and is facing backwards
			elif $sprite.flip_h == true:
				$animator.play("walk")
		if motion.x < 20 && motion.x > -20:
			$animator.play("idle")
	
	if motion.y > 0 && is_grounded != true:
		$animator.play("fall")
	if motion.y < 0 && is_grounded != true:
		$animator.play("jump")
	#print(is_grounded)


func _on_damagedetection_area_entered(area):
	if area.is_in_group("enemy-projectile"):
		health -= area.damage
	if area.get_collision_layer() == 64:
		health -= area.damage
