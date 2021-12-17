extends StaticBody2D

onready var sfx = get_node("/root/Audio")
const exp_scene = preload("res://effects/Explosion1.tscn")
export var ammo_type = preload("res://ammo/EAmmo0.tscn")
export (NodePath) var target_nodepath = null
var target_node
var target_pos
var can_fire
var fire_rate = .8
var health = 4

var points = 550

func _ready():
	target_node = get_node(target_nodepath)
	can_fire = true
	var mat = get_node("Sprite").get_material().duplicate(true)
	get_node("Sprite").set_material(mat)

func _process(delta):
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
