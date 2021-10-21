extends Node2D

var fire_rate = .25
var can_fire = true
export var ammo_type = preload("res://ammo/Ammo0.tscn")
export var start_pos = Vector2()
var muzzle_flip_offset = 2

func _ready():
	position = start_pos

func _process(delta):
	if Input.is_action_pressed("fire") and can_fire:
		shoot()
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func shoot():
	pass
	var projectile = ammo_type.instance()
	projectile.position = $Muzzle.global_position
	projectile.rotation = global_rotation
	get_tree().get_root().call_deferred("add_child", projectile)


func _on_Player_flipped():
	rotation_degrees = 180
	position.x = -start_pos.x
	$Muzzle.position.y = start_pos.y + muzzle_flip_offset
	$Sprite.flip_v = true

func _on_Player_not_flipped():
	rotation_degrees = 0
	position.x = start_pos.x
	$Muzzle.position.y = start_pos.y
	$Sprite.flip_v = false
