extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	visible = false

func _process(delta):
	$HSlider.value = Global.SFX_vol
	$HSlider2.value = Global.music_vol
	$CheckBox.pressed = Global.bloom
	$CheckBox2.pressed = Global.fullscreen
	
	if Global.show_options == false:
		visible = false
	elif Global.show_options == true:
		visible = true
	
	if Global.fullscreen == true:
		OS.window_fullscreen  = true
	elif Global.fullscreen == false:
		OS.window_fullscreen  = false

func _on_BackBtn_button_up():
	Global.show_options = false

func _on_BackBtn_button_down():
	sfx.select.play()

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear2db(value))
	Global.SFX_vol = value

func _on_CheckBox_toggled(button_pressed):
	if button_pressed == true:
		Global.bloom = true
	elif button_pressed == false:
		Global.bloom = false

func _on_CheckBox_button_down():
	sfx.select.play()

func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear2db(value))
	Global.music_vol = value

func _on_CheckBox2_toggled(button_pressed):
	if button_pressed == true:
		Global.fullscreen = true
	elif button_pressed == false:
		Global.fullscreen = false
