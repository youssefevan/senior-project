extends Control

func _process(delta):
	if Global.player_dead == true:
		self.visible = true
	elif Global.player_dead == false:
		self.visible = false

func _on_RetryBtn_button_up():
	get_tree().reload_current_scene()
	Global.player_dead = false
	Global.score = 0

func _on_MenuBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
	Global.player_dead = false
	Global.score = 0

func _on_QuitBtn_button_up():
	get_tree().quit()
