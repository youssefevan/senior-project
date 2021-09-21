extends Area2D

var speed
var vel
var damage

func movement(delta):
	vel = Vector2(speed * delta, 0).rotated(rotation)
	global_position += vel
