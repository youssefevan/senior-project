extends KinematicBody2D

export var ammo_type = preload("res://ammo/EAmmo0.tscn")
const exp_scene = preload("res://effects/Explosion2.tscn")

var grav = 1000
var velocity = Vector2.ZERO
var jump_force = 300

var idling = false
var crouching = false
var jumping = false
var recovering = false

var idle_time = 1
var crouch_time = 0.5
var recover_time = 1

var fire_rate = .8
var can_fire
var run = false

var points = 4000

export (NodePath) var target_nodepath = null
var target_node
var target_pos

var player_dir
var dir_multiplier = 100

var health = 20
var start

func _ready():
	target_node = get_node(target_nodepath)
	can_fire = true
	start = true
	Global.boss = self

func _exit_tree():
	Global.boss = null

func _process(delta):
	if start:
		idle()
		start = false
	
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if jumping && is_on_floor():
		recover()
	
	target_pos = target_node.global_position - position
	if target_pos.x >= 0:
		player_dir = 1
	elif target_pos.x < 0:
		player_dir = -1
	
	target_pos = target_node.global_position
	$Barrel/Animator.play("shoot")
	$Barrel.look_at(target_pos)
	
	if can_fire:
		shoot()
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	
	if health <= 0:
		die()
	
	if idling:
		#print("idle")
		$Animator.play("idle")
	
	if crouching:
		#print("crouching")
		$Animator.play("crouch")
	
	if jumping:
		#print("jumping")
		$Animator.play("jump")
	
	if recovering:
		#print("recovering")
		$Animator.play("recover")

func idle():
	idling = true
	yield(get_tree().create_timer(idle_time), "timeout")
	idling = false
	crouch()

func crouch():
	crouching = true
	yield(get_tree().create_timer(crouch_time), "timeout")
	crouching = false
	jump()

func jump():
	velocity.y = -jump_force
	velocity.x = player_dir * dir_multiplier
	jumping = true

func recover():
	jumping = false
	velocity.x = 0
	recovering = true
	yield(get_tree().create_timer(recover_time), "timeout")
	recovering = false
	idle()

func shoot():
	var ammo = ammo_type.instance()
	ammo.position = $Barrel/Sprite/Muzzle.global_position
	ammo.rotation = $Barrel/Sprite/Muzzle.global_rotation
	get_tree().get_root().call_deferred("add_child", ammo)


func _on_Hurtbox_area_entered(area):
	if area.get_collision_layer() == 16:
		health -= area.damage
		hit()

func hit():
	$ShaderAnimator.play("flash")

func die():
	explode()
	call_deferred("free")

func explode():
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)
