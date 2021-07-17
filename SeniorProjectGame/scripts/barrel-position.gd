extends Position2D

func _on_playerdetection_body_entered(body):
	if body.is_in_group("player"):
		look_at(body.global_position)
