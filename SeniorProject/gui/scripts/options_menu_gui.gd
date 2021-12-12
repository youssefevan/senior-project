extends Control

onready var sfx = get_node("/root/Audio")

func _on_BackBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")

func _on_BackBtn_button_down():
	sfx.select.play()
