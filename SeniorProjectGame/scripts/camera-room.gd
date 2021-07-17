extends Area2D

func _on_cameraroom_area_exited(area):
	if area.get_collision_layer() == 4:
		area.queue_free()
