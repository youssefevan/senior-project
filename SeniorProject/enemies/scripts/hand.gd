extends KinematicBody2D

const exp_scene = preload("res://effects/Explosion1.tscn")
const antic_scene = preload("res://effects/Rumble0.tscn")
const jump_scene = preload("res://effects/HandExplosion0.tscn")

var jump_force = 175
var grav = 1000

var player_detected = false
var grab_anim_time = 0.3
var health = 4

var velocity = Vector2()

var points = 450

func _ready():
	$Sprite.frame = 0

func _process(delta):
	#if player_detected == true:
		#$Sprite.frame = 1
	if player_detected == false and is_on_floor():
		$Sprite.frame = 0
	
	if $Sprite.frame == 0:
		$Hurtbox/HutboxShape.scale = Vector2.ZERO
		$Hurtbox/HutboxShape.position.y = 0
	else:
		$Hurtbox/HutboxShape.scale = Vector2(1, 1)
		$Hurtbox/HutboxShape.position.y = -8
	
	if health <= 0:
		die()
	
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_DetectAnticipation_area_entered(area):
	if area.get_collision_layer() == 1:
		var antic = antic_scene.instance()
		antic.position = position
		get_tree().get_root().call_deferred("add_child", antic)

func _on_PlayerDetection_area_entered(area):
	if area.get_collision_layer() == 1:
		$Sprite.frame = 1
		player_detected = true
		if is_on_floor():
			velocity.y = -jump_force
			var jump_exp = jump_scene.instance()
			jump_exp.position.x = position.x
			jump_exp.position.y = position.y - 4
			get_tree().get_root().call_deferred("add_child", jump_exp)

func _on_PlayerDetection_area_exited(area):
	if area.get_collision_layer() == 1:
		player_detected = false

func _on_Hitboxes_area_entered(area):
	if area.get_collision_layer() == 1:
		$Sprite.frame = 2
		yield(get_tree().create_timer(grab_anim_time), "timeout")
		$Sprite.frame = 1

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
	var explosion = exp_scene.instance()
	explosion.position.x = position.x
	explosion.position.y = position.y - 8
	get_tree().get_root().call_deferred("add_child", explosion)

func _on_KillzoneDetection_body_entered(body):
	if body.get_collision_layer() == 512:
		die()
