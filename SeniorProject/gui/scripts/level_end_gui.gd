extends Control

func _process(delta):
	if Global.level_end == true:
		self.visible = true
	elif Global.level_end == false:
		self.visible = false

func _on_NextBtn_button_up():
	pass # Replace with function body.

func _on_MenuBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
	Global.level_end = false
	get_tree().paused = false
