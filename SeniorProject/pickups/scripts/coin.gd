extends Area2D

const exp_scene = preload("res://effects/Pickup0.tscn")

var points = 10

func _on_Coin_body_entered(body):
	if body.get_collision_layer() == 1:
		die()

func die():
	Global.score += points
	explode()
	call_deferred("free")

func explode():
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)
