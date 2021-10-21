extends "res://ammo/scripts/ammo.gd"

func _ready():
	speed = 200
	damage = 1

func _process(delta):
	movement(delta)

func _on_Ammo0_area_entered(area):
	if area.get_collision_layer() == 4:
		call_deferred("free")
