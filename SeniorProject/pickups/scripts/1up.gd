extends Area2D

const exp_scene = preload("res://effects/Pickup0.tscn")

func _on_1up_body_entered(body):
	if body.get_collision_layer() == 1:
		if body.health < 4:
			body.health += 1
		die()

func die():
	explode()
	call_deferred("free")

func explode():
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)
