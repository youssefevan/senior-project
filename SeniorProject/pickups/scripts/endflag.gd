extends Area2D
onready var music = get_node("/root/Music")

func _on_Endflag_body_entered(body):
	if body.get_collision_layer() == 1:
		music.end.play()
		match Global.level:
			0:
				Global.level1_unlock = true
			1:
				Global.level2_unlock = true
			2:
				Global.level3_unlock = true
			3:
				Global.level4_unlock = true
			4:
				Global.level5_unlock = true
			5:
				Global.level6_unlock = true
			6:
				Global.level6_beat = true
		Global.level_end = true
		get_tree().paused = true
