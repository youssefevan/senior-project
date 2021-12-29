extends Area2D

func _on_CameraRoom_area_exited(area):
	if area.get_collision_layer() == 16 or area.get_collision_layer() == 64:
		area.queue_free()
