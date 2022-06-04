extends CanvasLayer

var exp0 = preload("res://effects/Explosion0.tscn")
var exp1 = preload("res://effects/Explosion1.tscn")
var exp2 = preload("res://effects/Explosion2.tscn")
var exp3 = preload("res://effects/Explosion3.tscn")
var flare0 = preload("res://effects/Flare0.tscn")
var h_exp0 = preload("res://effects/HandExplosion0.tscn")
var pickup0 = preload("res://effects/Pickup0.tscn")
var rumble0 = preload("res://effects/Rumble0.tscn")
var trail0 = preload("res://effects/Trail0.tscn")

var particles = [
	exp0, exp1, exp2, exp3,
	flare0, h_exp0, pickup0, rumble0, trail0
]

func ready():
	for i in particles:
		var particles_instance = Particles2D.new()
		particles_instance.position = Vector2(-64, -64)
		particles_instance.set_process_material(particles)
		particles_instance.set_one_shot(true)
		particles_instance.set_emitting(true)
		self.add_child(particles_instance)
