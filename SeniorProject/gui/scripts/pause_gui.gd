extends Control

onready var sfx = get_node("/root/Audio")

var pause_state = false
var enabled

func _ready():
	pause_state = false

func _process(delta):
	if !Global.show_mouse:
		$VBoxContainer/ContBtn.set_mouse_filter(2)
		$VBoxContainer/RestartBtn.set_mouse_filter(2)
		$VBoxContainer/MenuBtn.set_mouse_filter(2)
	
	if visible:
		if !enabled:
			$VBoxContainer/ContBtn.call_deferred("grab_focus")
			enabled = true
	else:
		enabled = false
	
	if Input.is_action_just_pressed("pause"):
		if Global.player_dead == false && Global.level_end == false:
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
	get_tree().change_scene("res://levels/OptionsMenu.tscn")

func _on_RestartBtn_button_down():
	sfx.select.play()
