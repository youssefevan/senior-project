extends Node2D

export(PackedScene) var plProjectile = preload("res://scenes/default-projectile.tscn")

var fire_rate;
var ammo_type;

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	var projectile = plProjectile.instance()
	projectile.position = global_position
	projectile.rotation = global_rotation
	get_tree().get_root().call_deferred("add_child", projectile)
