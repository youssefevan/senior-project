extends Control

onready var sfx = get_node("/root/Audio")

func _ready():
	Global.checkpoint_reached = false

# just a mess

func _process(delta):
	if Global.level1_unlock == true:
		$VBoxContainer/Lv1Btn.disabled = false
	else:
		$VBoxContainer/Lv1Btn.disabled = true
	
	if Global.level2_unlock == true:
		$VBoxContainer/Lv2Btn.disabled = false
	else:
		$VBoxContainer/Lv2Btn.disabled = true
	
	if Global.level3_unlock == true:
		$VBoxContainer/Lv3Btn.disabled = false
	else:
		$VBoxContainer/Lv3Btn.disabled = true
	
	if Global.level4_unlock == true:
		$VBoxContainer/Lv4Btn.disabled = false
	else:
		$VBoxContainer/Lv4Btn.disabled = true
	
	if Global.level5_unlock == true:
		$VBoxContainer/Lv5Btn.disabled = false
	else:
		$VBoxContainer/Lv5Btn.disabled = true

func _on_TutBtn_button_up():
	get_tree().change_scene("res://levels/Tutorial.tscn")

func _on_Lv1Btn_button_up():
	get_tree().change_scene("res://levels/Level1.tscn")

func _on_Lv2Btn_button_up():
	get_tree().change_scene("res://levels/Level2.tscn")

func _on_Lv3Btn_button_up():
	get_tree().change_scene("res://levels/Level3.tscn")

func _on_Lv4Btn_button_up():
	get_tree().change_scene("res://levels/Level4.tscn")

func _on_Lv5Btn_button_up():
	get_tree().change_scene("res://levels/Level5.tscn")

func _on_BackBtn_button_up():
	get_tree().change_scene("res://levels/MainMenu.tscn")

# this is bad
func _on_TutBtn_button_down():
	sfx.select.play()

func _on_Lv1Btn_button_down():
	sfx.select.play()

func _on_Lv2Btn_button_down():
	sfx.select.play()

func _on_Lv3Btn_button_down():
	sfx.select.play()

func _on_Lv4Btn_button_down():
	sfx.select.play()

func _on_Lv5Btn_button_down():
	sfx.select.play()

func _on_BackBtn_button_down():
	sfx.unpause.play()
