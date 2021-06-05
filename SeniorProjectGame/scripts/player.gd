extends KinematicBody2D

signal grounded_update(is_grounded)

const GROUND_ACCEL = 850
const AIR_ACCEL = 425
const MAX_SPEED = 75
const GROUND_FRIC = .1
const AIR_FRIC = .01
const GRAV = 600
const DOWN_GRAV = 1400
const JUMP_FORCE = 200
const MIN_JUMP_HEIGHT = 90
const MAX_FALL_SPEED = 300

var grav = 0
var accel = 0
var fric = 0
var motion = Vector2.ZERO
var canPhantomJump = true
var jumpWasPressed = false
var x_input = 0
var is_grounded

func _process(delta):
	
	x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * accel * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, fric)
	
	motion.y += grav * delta
	
	if is_on_floor():
		accel = GROUND_ACCEL
		fric = GROUND_FRIC
		canPhantomJump = true
		if jumpWasPressed == true:
			motion.y = -JUMP_FORCE
	else:
		accel = AIR_ACCEL
		fric = AIR_FRIC
	
	if Input.is_action_just_pressed("ui_up"):
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
	
	
	motion = move_and_slide(motion, Vector2.UP)

func coyoteTime():
	yield(get_tree().create_timer(.055), "timeout")
	canPhantomJump = false

func rememberJumpTime():
	yield(get_tree().create_timer(.075), "timeout")
	jumpWasPressed = false

func _on_cameraroomdetection_area_entered(area):
	var size = area.global_scale * 2
	
	var cam = $camera
	cam.limit_top = area.global_position.y - size.y/2
	cam.limit_left = area.global_position.x - size.x/2
	cam.limit_bottom = cam.limit_top + size.y
	cam.limit_right = cam.limit_left + size.x
	
	print(size)
