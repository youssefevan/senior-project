extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	pass

func _process(delta):
	pass

func _on_StartBtn_button_up():
	get_tree().change_scene("res://levels/LevelSelect.tscn")

func _on_QuitBtn_button_up():
	Global.quit = true

func _on_StartBtn_button_down():
	sfx.select.play()

func _on_OptBtn_button_up():
	Global.show_options = true

func _on_OptBtn_button_down():
	sfx.select.play()
