extends Control

func _process(delta):
	$HealthFull.rect_size.x = 16 * Global.player.health
