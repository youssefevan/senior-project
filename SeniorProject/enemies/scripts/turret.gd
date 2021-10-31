extends StaticBody2D

export var ammo_type = preload("res://ammo/EAmmo0.tscn")
export (NodePath) var target_nodepath = null
var target_node
var target_pos
var can_fire
var fire_rate = .8


func _ready():
	target_node = get_node(target_nodepath)
	can_fire = true

func _process(delta):
	target_pos = target_node.global_position
	$Barrel.look_at(target_pos)
	if can_fire:
		shoot()
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func shoot():
	var ammo = ammo_type.instance()
	ammo.position = $Barrel/Sprite/Muzzle.global_position
	ammo.rotation = $Barrel/Sprite/Muzzle.global_rotation
	get_tree().get_root().call_deferred("add_child", ammo)
