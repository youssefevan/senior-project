extends KinematicBody2D

signal grounded(is_grounded)
signal not_grounded()
signal camera_room(cr_size, cr_pos)
signal flipped()
signal not_flipped()
signal dead()

export (NodePath) var spawn_nodepath = null
var spawn

export (NodePath) var checkpoint_nodepath = null
var checkpoint

const exp_scene1 = preload("res://effects/Explosion2.tscn")
const exp_scene2 = preload("res://effects/Explosion1.tscn")

onready var sfx = get_node("/root/Audio")

onready var animator = $Animator
onready var sprite = $Sprite
onready var blaster = $Blaster

const MAX_SPEED = 85
const JUMP_FORCE = 208
const GRAV = 600
const DOWN_GRAV = 1400
const MAX_FALL_SPEED = 250

const GROUND_ACCEL = 865
const AIR_ACCEL = 575
const GROUND_FRIC = 13.5
const AIR_FRIC = 1.4
const MIN_JUMP_HEIGHT = 90

var grav = 600
var velocity = Vector2.ZERO
var x_input = Vector2.ZERO
var accel = 0
var fric = 0

var hitstun = false
var hitstun_time = .15

export (int) var health = 4
var is_hurt = false
var i_time = 1

var frozen = false

#var is_grounded
#var facing = 0

var jumpWasPressed = false #phantom jump
var canCoyoteJump = false

var cr_size = Vector2()
var cr_pos = Vector2()

var dead_pos = Vector2()

var ended

func _ready():
	ended = false
	frozen = false
	hitstun = false
	Global.player = self
	$ShaderAnimator.play("default")
	spawn = get_node(spawn_nodepath)
	checkpoint = get_node(checkpoint_nodepath)
	match Global.checkpoint_reached:
		false:
			global_position = spawn.global_position
		true:
			global_position = checkpoint.global_position

func _exit_tree():
	Global.player = null

func apply_gravity(delta):
	velocity.y += grav * delta

func apply_movement():
	if hitstun == true:
		var temp = velocity
		velocity = Vector2.ZERO
	else:
		velocity = velocity
	
	if abs(velocity.x) <= 0.05:
		velocity.x = 0
	else:
		velocity.x = velocity.x
	
	print(velocity.x)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	#(Global.score)

func handle_move_input(delta):
	pass
	#print(x_input)
	if !frozen:
		x_input = Input.get_action_strength("right") - Input.get_action_strength("left")

		# smooth in and out
		if x_input != 0:
			velocity.x += x_input * accel * delta
			velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)
		else:
			velocity.x = lerp(velocity.x, 0, fric * delta)
		#print(velocity.x)
	else:
		if ended == true:
			x_input = 0
			velocity.x = 0
			velocity.y = 0
			$Blaster.can_fire = false
		else:
			x_input = 0
			velocity.x = 50

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
	
	if area.get_collision_layer() == 8192:
		Global.boss_trigger = true

func _on_Hurtbox_area_entered(area):
	if area.get_collision_layer() == 8192:
		if Global.boss_trigger == false:
			boss_start()
	
	if area.get_collision_layer() == 16384:
		Global.boss_beat = true
	
	if area.get_collision_layer() == 32768:
		Global.ending = true
		ending()
	
	if area.get_collision_layer() == 128 or area.get_collision_layer() == 64 or area.get_collision_layer() == 8:
		hit()

func boss_start():
	frozen = true
	yield(get_tree().create_timer(1), "timeout")
	frozen = false
	Global.boss_start = true

func ending():
	frozen = true
	yield(get_tree().create_timer(1.2), "timeout")
	ended = true
	Global.ending = false
	Global.level_end = true

func hit():
	if is_hurt == false:
		$ShaderAnimator.play("hit")
		sfx.phit.play()
		health -= 1
		#print(health)
		
		if health <= 0:
			die()
		
		#hitstun()
		
		is_hurt = true
		yield(get_tree().create_timer(i_time), "timeout")
		is_hurt = false

func hitstun():
	hitstun = true
	yield(get_tree().create_timer(hitstun_time), "timeout")
	hitstun = false

func die():
	#dead_pos = global_position
	#emit_signal("dead", dead_pos)
	
	Global.player_dead = true
	
	var explosion1 = exp_scene1.instance()
	explosion1.position = global_position
	get_tree().get_root().call_deferred("add_child", explosion1)
	
	#var explosion2 = exp_scene2.instance()
	#explosion2.position = global_position
	#get_tree().get_root().call_deferred("add_child", explosion2)
	
	$StateMachine.set_process(false)
	$Blaster.set_process(false)
	$Hurtbox.call_deferred("free")
	$KillzoneDetection.call_deferred("free")
	$Sprite.hide()
	$Collider.call_deferred("free")
	$Hurtbox.call_deferred("free")
	
	#print("dead")

#func _on_CameraRoom_area_exited(area):
	#pass # Replace with function body.

func _on_KillzoneDetection_body_entered(body):
	if body.get_collision_layer() == 512:
		sfx.phit.play()
		die()
