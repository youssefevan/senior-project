extends KinematicBody2D

const ACCEL = 1500
const MAX_SPEED = 200
const FRIC = .25
const GRAV = 1000
const JUMP_FORCE = 415
const MIN_JUMP_HEIGHT = 175

var motion = Vector2.ZERO
var canPhantomJump = true
var jumpWasPressed = false

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if x_input != 0:
		motion.x += x_input * ACCEL * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
	else:
		motion.x = lerp(motion.x, 0, FRIC)
	
	motion.y += GRAV * delta
	
	if is_on_floor():
		canPhantomJump = true
		if jumpWasPressed == true:
			motion.y = -JUMP_FORCE
	
	if Input.is_action_just_pressed("ui_up"):
		jumpWasPressed = true
		rememberJumpTime()
		if canPhantomJump == true:
			motion.y = -JUMP_FORCE
	
	if !is_on_floor():
		coyoteTime()
	
	if Input.is_action_just_released("ui_up") and motion.y < -MIN_JUMP_HEIGHT:
		motion.y = -MIN_JUMP_HEIGHT
	
	motion = move_and_slide(motion, Vector2.UP)

func coyoteTime():
	yield(get_tree().create_timer(.07), "timeout")
	canPhantomJump = false

func rememberJumpTime():
	yield(get_tree().create_timer(.07), "timeout")
	jumpWasPressed = false
