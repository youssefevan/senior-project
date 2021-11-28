extends Area2D

func _on_Endflag_area_entered(area):
	if area.get_collision_layer() == 1:
		Global.level_end = true
		get_tree().paused = true
