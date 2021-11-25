extends Control

var pause_state = false

func _ready():
	pause_state = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause_state = not get_tree().paused
		get_tree().paused = not get_tree().paused
	
	visible = pause_state

func _on_ContBtn_button_up():
	get_tree().paused = not get_tree().paused
	pause_state = false

func _on_MenuBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
	get_tree().paused = not get_tree().paused
	pause_state = false

func _on_RestartBtn_button_up():
	get_tree().reload_current_scene()
	get_tree().paused = not get_tree().paused
	pause_state = false
