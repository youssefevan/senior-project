extends KinematicBody2D

const GROUND_ACCEL = 1800
const AIR_ACCEL = 900
const MAX_SPEED = 200
const FRIC = .25
const GRAV = 1000
const DOWN_GRAV = 2000
const JUMP_FORCE = 415
const MIN_JUMP_HEIGHT = 175

var grav = 1000
var accel = 1500
var motion = Vector2.ZERO
var canPhantomJump = true
var jumpWasPressed = false

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * accel * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRIC)
	
	motion.y += grav * delta
	
	if is_on_floor():
		accel = GROUND_ACCEL
		canPhantomJump = true
		if jumpWasPressed == true:
			motion.y = -JUMP_FORCE
	else:
		accel = AIR_ACCEL
	
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
	
	motion = move_and_slide(motion, Vector2.UP)
	print(accel)

func coyoteTime():
	yield(get_tree().create_timer(.07), "timeout")
	canPhantomJump = false

func rememberJumpTime():
	yield(get_tree().create_timer(.07), "timeout")
	jumpWasPressed = false
