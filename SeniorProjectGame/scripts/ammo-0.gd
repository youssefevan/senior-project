extends "res://scripts/default-projectile.gd"


func _ready():
	speed = 150
	damage = 2

func _process(delta):
	movement(delta)
	animation()

func animation():
	sprite_flipping()
	$animator.play("flash")
