extends Position2D

func _on_Player_flipped():
	position = Vector2(-7,-1)
	rotation_degrees = 180

func _on_Player_not_flipped():
	position = Vector2(7,-1)
	rotation_degrees = 0
