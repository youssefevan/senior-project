extends Area2D

var speed;

func _process(delta):
	speed = 150
	var vel = Vector2(speed * delta, 0).rotated(rotation)
	global_position += vel
	$animator.play("flash")
