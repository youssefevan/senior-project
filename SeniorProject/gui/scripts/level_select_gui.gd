extends Control

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
