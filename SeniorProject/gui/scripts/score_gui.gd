extends Control

func _process(delta):
	$ScoreText.text = str(Global.score)
