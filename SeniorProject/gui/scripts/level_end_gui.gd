extends Control

# setting score manually is bad

func _process(delta):
	#if get_tree().current_scene("Level5"):
	#	$VBoxContainer/NextBtn.hide()
	
	if Global.level_end == true:
		self.visible = true
	elif Global.level_end == false:
		self.visible = false

func _on_NextBtn_button_up():
	Global.score = 0

func _on_MenuBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
	Global.level_end = false
	get_tree().paused = false
	Global.score = 0

func _on_RestartBtn_button_up():
	get_tree().reload_current_scene()
	Global.level_end = false
	get_tree().paused = false
	Global.score = 0
