extends "res://ammo/scripts/ammo.gd"

func _ready():
	speed = 200
	damage = 1
	exp_scene = preload("res://effects/Explosion0.tscn")

func _process(delta):
	movement(delta)

func _on_Ammo0_area_entered(area):
	if area.get_collision_layer() == 4:
		explode()
