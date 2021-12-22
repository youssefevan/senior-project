extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	visible = false

func _process(delta):
	$HSlider.value = Global.SFX_vol
	
	if Global.show_options == false:
		visible = false
	elif Global.show_options == true:
		visible = true

func _on_BackBtn_button_up():
	Global.show_options = false

func _on_BackBtn_button_down():
	sfx.select.play()

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))
	Global.SFX_vol = value
