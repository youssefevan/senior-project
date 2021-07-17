extends Position2D

var player = null
export var ammo_type = preload("res://scenes/turret-ammo-0.tscn");
var fire_rate = .5
var can_shoot = true

func _process(delta):
	player_detected()

func player_detected():
	if player != null:
		look_at(player.global_position)
		print(player.global_position)
		if can_shoot == true:
			shoot()
			can_shoot = false
			yield(get_tree().create_timer(fire_rate), "timeout")
			can_shoot = true

func _on_playerdetection_body_entered(body):
	if body.is_in_group("player"):
		player = body
		player_detected()

func _on_playerdetection_body_exited(body):
	if body.is_in_group("player"):
		player = null

func shoot():
	var projectile = ammo_type.instance()
	projectile.position = $"barrel-rotation2/barrel-position/sprite2/muzzle-position".global_position
	projectile.rotation = global_rotation
	get_tree().get_root().call_deferred("add_child", projectile)
