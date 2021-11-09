extends KinematicBody2D

signal grounded(is_grounded)
signal not_grounded()
signal camera_room(cr_size, cr_pos)
signal flipped()
signal not_flipped()
signal dead()

const exp_scene1 = preload("res://effects/Explosion2.tscn")
const exp_scene2 = preload("res://effects/Explosion1.tscn")

onready var animator = $Animator
onready var sprite = $Sprite

const MAX_SPEED = 85
const JUMP_FORCE = 200
const GRAV = 600
const DOWN_GRAV = 1400
const MAX_FALL_SPEED = 250

const GROUND_ACCEL = 850
const AIR_ACCEL = 555
const GROUND_FRIC = .1
const AIR_FRIC = .01
const MIN_JUMP_HEIGHT = 90

var grav = 600
var velocity = Vector2.ZERO
var x_input = Vector2.ZERO
var accel = 0
var fric = 0

var health = 4
var is_hurt = false
var i_time = 1.2

#var is_grounded
#var facing = 0

var jumpWasPressed = false #phantom jump
var canCoyoteJump = false

var cr_size = Vector2()
var cr_pos = Vector2()

var dead_pos = Vector2()

func apply_gravity(delta):
	velocity.y += grav * delta

func apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)

func handle_move_input(delta):
	x_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	# smooth in and out
	if x_input != 0:
		velocity.x += x_input * accel * delta
		velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
	else:
		velocity.x = lerp(velocity.x, 0, fric)

#func update_grounded():
#	var was_grounded = is_grounded
#	is_grounded = is_on_floor()
#	
#	if was_grounded == null || is_grounded != was_grounded:
#		emit_signal("grounded_update", is_grounded)

func rememberJumpTime():
	yield(get_tree().create_timer(.075), "timeout")
	jumpWasPressed = false

func coyoteTime():
	yield(get_tree().create_timer(.075), "timeout")
	canCoyoteJump = false

func _on_CameraRoomDetector_area_entered(area):
	if area.get_collision_layer() == 32:
		cr_size = area.global_scale
		cr_pos = area.global_position
		emit_signal("camera_room", cr_size, cr_pos)

func _on_Hurtbox_area_entered(area):
	if area.get_collision_layer() == 128 or area.get_collision_layer() == 64 or area.get_collision_layer() == 8:
		hit()

func hit():
	if is_hurt == false:
		$ShaderAnimator.play("hit")
		health -= 1
		print(health)
		
		if health <= 0:
			die()
		
		is_hurt = true
		yield(get_tree().create_timer(i_time), "timeout")
		is_hurt = false

func die():
	#dead_pos = global_position
	#emit_signal("dead", dead_pos)
	
	var explosion1 = exp_scene1.instance()
	explosion1.position = global_position
	get_tree().get_root().call_deferred("add_child", explosion1)
	
	#var explosion2 = exp_scene2.instance()
	#explosion2.position = global_position
	#get_tree().get_root().call_deferred("add_child", explosion2)
	
	print("dead")
