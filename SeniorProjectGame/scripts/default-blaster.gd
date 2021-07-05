extends Node2D

var fire_rate = .2
var can_shoot = true
export var ammo_type = preload("res://scenes/ammo-0.tscn");

func _process(delta):
	if Input.is_action_pressed("shoot") and can_shoot:
		shoot()
		can_shoot = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_shoot = true

func shoot():
	var projectile = ammo_type.instance()
	projectile.position = $muzzle.global_position
	projectile.rotation = global_rotation
	get_tree().get_root().call_deferred("add_child", projectile)
