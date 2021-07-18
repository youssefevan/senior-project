extends Area2D

var speed
var firerate
var vel
var damage

func movement(delta):
	vel = Vector2(speed * delta, 0).rotated(rotation)
	global_position += vel

func _on_defaultprojectile_body_entered(body):
	if body.is_in_group("tiles"):
		queue_free()

func sprite_flipping():
	if vel.x >= 0:
		$sprite.flip_v = false
	elif vel.x < 0:
		$sprite.flip_v = true
