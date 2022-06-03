extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	if visible:
		$VBoxContainer/SFXslider.call_deferred("grab_focus")

func _process(delta):
	if !Global.show_mouse:
		$BackBtn.set_mouse_filter(2)
		$VBoxContainer/SFXslider.set_mouse_filter(2)
		$VBoxContainer/MusicSlider.set_mouse_filter(2)
		$VBoxContainer/BloomToggle.set_mouse_filter(2)
		$VBoxContainer/ParticlesToggle.set_mouse_filter(2)
		$VBoxContainer/FullscreenToggle.set_mouse_filter(2)
		$VBoxContainer/CursorToggle.set_mouse_filter(2)
	
	$VBoxContainer/SFXslider.value = Global.SFX_vol
	$VBoxContainer/MusicSlider.value = Global.music_vol
	$VBoxContainer/BloomToggle.pressed = Global.bloom
	$VBoxContainer/ParticlesToggle.pressed = Global.enable_particles
	$VBoxContainer/FullscreenToggle.pressed = Global.fullscreen
	$VBoxContainer/CursorToggle.pressed = Global.show_mouse
	
	if Global.fullscreen == true:
		OS.window_fullscreen  = true
	elif Global.fullscreen == false:
		OS.window_fullscreen  = false

func _on_BackBtn_button_up():
	Global.save()
	match Global.previous_scene:
		"main":
			get_tree().change_scene("res://levels/MainMenu.tscn")

func _on_BackBtn_button_down():
	sfx.select.play()

func _on_CheckBox_toggled(button_pressed):
	if button_pressed == true:
		Global.bloom = true
	elif button_pressed == false:
		Global.bloom = false

func _on_CursorToggle_toggled(button_pressed):
	if button_pressed == true:
		Global.show_mouse = true
	elif button_pressed == false:
		Global.show_mouse = false

func _on_SFXslider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))
	Global.SFX_vol = value

func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))
	Global.music_vol = value

func _on_FullscreenToggle_toggled(button_pressed):
	if button_pressed == true:
		Global.fullscreen = true
	elif button_pressed == false:
		Global.fullscreen = false

func _on_BloomToggle_toggled(button_pressed):
	if button_pressed == true:
		Global.bloom = true
	elif button_pressed == false:
		Global.bloom = false

func _on_BloomToggle_button_down():
	sfx.select.play()

func _on_FullscreenToggle_button_down():
	sfx.select.play()

func _on_CursorToggle_button_down():
	sfx.select.play()

func _on_ParticlesToggle_button_down():
	sfx.select.play()

func _on_ParticlesToggle_toggled(button_pressed):
	if button_pressed == true:
		Global.enable_particles = true
	elif button_pressed == false:
		Global.enable_particles = false
