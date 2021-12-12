extends Control

onready var sfx = get_node("/root/Audio")

# setting score manually is bad

func _process(delta):
	#if get_tree().current_scene("Level5"):
	#	$VBoxContainer/NextBtn.hide()
	
	if Global.level_end == true:
		self.visible = true
	elif Global.level_end == false:
		self.visible = false

func _on_NextBtn_button_up():
	Global.checkpoint_reached = false
	match Global.level:
		0:
			get_tree().change_scene("res://levels/Level1.tscn")
		1:
			get_tree().change_scene("res://levels/Level2.tscn")
		2:
			get_tree().change_scene("res://levels/Level3.tscn")
		3:
			get_tree().change_scene("res://levels/Level4.tscn")
		4:
			get_tree().change_scene("res://levels/Level5.tscn")
	Global.level_end = false
	get_tree().paused = false
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

func _on_NextBtn_button_down():
	sfx.select.play()

func _on_MenuBtn_button_down():
	sfx.unpause.play()

func _on_RestartBtn_button_down():
	sfx.select.play()
