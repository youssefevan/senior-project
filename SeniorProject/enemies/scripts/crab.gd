extends KinematicBody2D

const exp_scene = preload("res://effects/Explosion1.tscn")

var velocity = Vector2()
var grav = 1000
var speed = 25
var accel = 500

var motion = Vector2.ZERO
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var dir = left

var health = 3

var points = 100

onready var sfx = get_node("/root/Audio")

func _ready():
	var mat = get_node("Sprite").get_material().duplicate(true)
	get_node("Sprite").set_material(mat)

func _process(delta):
	
	if is_on_wall():
		if dir == left:
			dir = right
		elif dir == right:
			dir = left
	
	velocity.y += grav * delta
	
	velocity.x += dir.x * accel * delta
	velocity.x = clamp(velocity.x, -speed, speed)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	animate()
	
	if health <= 0:
		die()

func animate():
	$Animator.play("move")

func _on_Hurtbox_area_entered(area):
	if area.get_collision_layer() == 16:
		health -= area.damage
		hit()

func hit():
	$ShaderAnimator.play("flash")

func die():
	Global.score += points
	explode()
	call_deferred("free")

func explode():
	sfx.edeath.play()
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)

func _on_KillzoneDetection_body_entered(body):
	if body.get_collision_layer() == 512:
		die()
