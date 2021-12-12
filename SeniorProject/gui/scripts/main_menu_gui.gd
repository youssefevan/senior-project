extends Control

onready var sfx = get_node("/root/Audio")

func _on_StartBtn_button_up():
	get_tree().change_scene("res://levels/LevelSelect.tscn")

func _on_QuitBtn_button_up():
	get_tree().quit()

func _on_StartBtn_button_down():
	sfx.select.play()

func _on_QuitBtn_button_down():
	#sfx.select.play()
	pass

func _on_OptBtn_button_up():
	get_tree().change_scene("res://levels/OptionsMenu.tscn")

func _on_OptBtn_button_down():
	sfx.select.play()
