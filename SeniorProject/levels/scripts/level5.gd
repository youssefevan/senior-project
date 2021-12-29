extends Node2D

func _ready():
	Global.level = 5
	Global.boss_trigger = false
	Global.boss_dead = false
	#Global.show_mouse = false
	Global.previous_scene = "level5"
	Global.boss_start = false
	Global.boss_beat = false
