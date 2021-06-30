extends Node2D

var fire_rate;
export var ammo_type = preload("res://scenes/ammo-0.tscn");

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var projectile = ammo_type.instance()
	projectile.position = $muzzle.global_position
	projectile.rotation = global_rotation
	get_tree().get_root().call_deferred("add_child", projectile)
