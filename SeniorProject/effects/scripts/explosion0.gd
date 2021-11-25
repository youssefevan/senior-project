extends Particles2D

var expire = 1.5

func _ready():
	set_emitting(true)
	time()

func time():
	yield(get_tree().create_timer(expire), "timeout")
	call_deferred("free")
