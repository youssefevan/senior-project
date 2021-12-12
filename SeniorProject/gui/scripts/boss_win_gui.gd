extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	visible = false

func _process(delta):
	if Global.boss_dead == true:
		print(Global.boss_dead)
		visible = true

func _on_Button_button_down():
	sfx.select.play()

func _on_Button_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
