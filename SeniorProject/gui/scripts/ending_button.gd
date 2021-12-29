extends Button

func _process(delta):
	if Global.ending == true:
		self.grab_focus()
