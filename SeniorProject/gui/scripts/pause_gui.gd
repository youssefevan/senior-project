extends Control

onready var sfx = get_node("/root/Audio")

var pause_state = false

func _ready():
	pause_state = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_state = not get_tree().paused
		get_tree().paused = not get_tree().paused
		
		if pause_state == true:
			sfx.pause.play()
		if pause_state == false:
			sfx.unpause.play()
	
	visible = pause_state

func _on_ContBtn_button_up():
	get_tree().paused = not get_tree().paused
	pause_state = false
	sfx.unpause.play()

func _on_MenuBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
	get_tree().paused = not get_tree().paused
	pause_state = false
	Global.score = 0

func _on_RestartBtn_button_up():
	get_tree().reload_current_scene()
	get_tree().paused = not get_tree().paused
	pause_state = false
	Global.score = 0

func _on_OptDtn_button_down():
	sfx.select.play()

func _on_MenuBtn_button_down():
	sfx.select.play()

func _on_OptDtn_button_up():
	Global.show_options = true

func _on_RestartBtn_button_down():
	sfx.select.play()
