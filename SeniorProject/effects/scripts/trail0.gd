extends Particles2D

func _ready():
	if Global.enable_particles == true:
		set_emitting(true)
	else:
		set_emitting(false)
