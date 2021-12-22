extends WorldEnvironment

export (Environment) var env
export (Environment) var default

func _process(delta):
	if Global.bloom == true:
		environment = env
	elif Global.bloom == false:
		environment = default
