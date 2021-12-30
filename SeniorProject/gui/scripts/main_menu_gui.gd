extends Control

onready var sfx = get_node("/root/Audio")
onready var music = get_node("/root/Music")

var enabled

func _ready():
	play_music()
	$Menu/StartBtn.grab_focus()
	Global.previous_scene = "main"
	Global.boss_start = false
	
	if Global.fullscreen == true:
		OS.window_fullscreen  = true
	elif Global.fullscreen == false:
		OS.window_fullscreen  = false

func _on_StartBtn_button_up():
	get_tree().change_scene("res://levels/LevelSelect.tscn")

func _on_QuitBtn_button_up():
	Global.quit = true
	get_tree().quit()

func _on_StartBtn_button_down():
	sfx.select.play()

func _on_OptBtn_button_up():
	get_tree().change_scene("res://levels/OptionsMenu.tscn")

func _on_OptBtn_button_down():
	sfx.select.play()

func play_music():
	yield(get_tree().create_timer(.7), "timeout")
	if !music.theme.playing:
		music.theme.play()
