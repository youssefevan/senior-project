extends Area2D

func _on_Checkpoint_body_entered(body):
	if body.get_collision_layer() == 1:
		Global.checkpoint_reached = true
