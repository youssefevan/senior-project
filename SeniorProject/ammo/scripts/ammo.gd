extends Area2D

var speed
var vel
var damage

func movement(delta):
	vel = Vector2(speed * delta, 0).rotated(rotation)
	global_position += vel

func _on_VisibilityEnabler2D_viewport_exited(viewport):
	call_deferred("free")

func _on_Ammo_body_entered(body):
	if body.get_collision_layer() == 2:
		call_deferred("free")
