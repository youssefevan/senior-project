extends Control

func _on_StartBtn_button_up():
	get_tree().change_scene("res://levels/LevelSelect.tscn")

func _on_QuitBtn_button_up():
	get_tree().quit()
