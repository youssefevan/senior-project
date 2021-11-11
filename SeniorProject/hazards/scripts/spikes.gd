extends StaticBody2D

func _physics_process(delta):
	$Animator.play("shine")
	#$Sprite.rotation_degrees += 3
