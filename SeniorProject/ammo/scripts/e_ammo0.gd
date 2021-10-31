extends "res://ammo/scripts/ammo.gd"

func _ready():
	speed = 100
	damage = 1

func _process(delta):
	movement(delta)

func _on_EAmmo0_area_entered(area):
	if area.get_collision_layer() == 1:
		explode()
