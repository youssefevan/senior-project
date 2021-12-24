extends "res://ammo/scripts/ammo.gd"

func _ready():
	speed = 120
	damage = 1
	exp_scene = preload("res://effects/Explosion3.tscn")

func _process(delta):
	movement(delta)

func _on_EAmmo0_area_entered(area):
	if area.get_collision_layer() == 1 && Global.player_dead != true:
		explode()
