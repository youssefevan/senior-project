extends "res://ammo/scripts/ammo.gd"


func _ready():
	speed = 200
	damage = 1

func _process(delta):
	movement(delta)
