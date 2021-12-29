extends KinematicBody2D

var temp

func _ready():
	temp = global_position.y

func _process(delta):
	if Global.boss_start and !Global.boss_dead:
		if global_position.y != temp+32:
			global_position.y += 8
		else:
			global_position.y = global_position.y
	
	if Global.boss_dead:
		if global_position.y != temp:
			global_position.y -= 1
		else:
			global_position.y = global_position.y
