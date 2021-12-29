extends Control

onready var sfx = get_node("/root/Audio")
var enabled

func _ready():
	visible = false

func _process(delta):
	if visible:
		if !enabled:
			$Button.call_deferred("grab_focus")
			enabled = true
	else:
		enabled = false
	
#	if Global.boss_dead == true:
#		visible = true
#		get_tree().paused = true

func _on_Button_button_down():
	sfx.select.play()

func _on_Button_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")
