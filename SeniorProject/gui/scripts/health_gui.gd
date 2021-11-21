extends Control

func _process(delta):
	$HealthFull.rect_size.x = 16 * Global.player.health
	if Global.player.health <= 0:
		$HealthFull.visible = false
