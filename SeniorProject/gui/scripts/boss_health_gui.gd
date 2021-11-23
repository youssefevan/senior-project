extends Control

func _process(delta):
	if Global.boss != null:
		if Global.boss_trigger == true:
			visible = true
		else:
			visible = false
		$HealthFull.rect_size.x = 3 * Global.boss.health
