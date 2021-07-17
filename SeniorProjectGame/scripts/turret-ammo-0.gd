extends "res://scripts/default-projectile.gd"

func _ready():
	speed = 100
	firerate = 500

func _process(delta):
	movement(delta)
	animation()

func animation():
	sprite_flipping()
	$animator.play("flash")
