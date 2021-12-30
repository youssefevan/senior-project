extends Control

onready var sfx = get_node("/root/Audio")

var enabled

func _ready():
	visible = false

func _process(delta):
	if !Global.show_mouse:
		$VBoxContainer/MenuBtn.set_mouse_filter(2)
		$VBoxContainer/RetryBtn.set_mouse_filter(2)
	
	if visible:
		if !enabled:
			$VBoxContainer/RetryBtn.call_deferred("grab_focus")
			enabled = true
	else:
		enabled = false
	
	if Global.player_dead == true:
		self.visible = true
		
		if Input.is_action_pressed("restart"):
			get_tree().reload_current_scene()
			Global.player_dead = false
			Global.score = 0
		
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

func _on_OptBtn_button_down():
	sfx.select.play()

func _on_OptBtn_button_up():
	get_tree().change_scene("res://levels/OptionsMenu.tscn")

func _on_RetryBtn_button_down():
	sfx.select.play()

func _on_MenuBtn_button_down():
	sfx.select.play()
