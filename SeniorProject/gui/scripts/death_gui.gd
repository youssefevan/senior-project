extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	visible = false

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

func _on_OptBtn_button_down():
	sfx.select.play()

func _on_OptBtn_button_up():
	Global.show_options = true

func _on_RetryBtn_button_down():
	sfx.select.play()

func _on_MenuBtn_button_down():
	sfx.select.play()
