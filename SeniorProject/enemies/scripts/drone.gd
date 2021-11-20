extends KinematicBody2D

const exp_scene = preload("res://effects/Explosion1.tscn")

var velocity = Vector2(-50, 50)
var health = 2

var rot_speed = 500

var points = 120

func _ready():
	var mat = get_node("Sprite").get_material().duplicate(true)
	get_node("Sprite").set_material(mat)

func _process(delta):
	$Sprite.rotation_degrees += rot_speed * delta
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		velocity = velocity.bounce(collision.normal)
	
	if health <= 0:
		die()

func _on_Hutbox_area_entered(area):
	if area.get_collision_layer() == 16:
		health -= area.damage
		hit()

func hit():
	$ShaderAnimator.play("flash")

func die():
	Global.score += points
	explode()
	call_deferred("free")

func explode():
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)


func _on_KillzoneDetection_body_entered(body):
	if body.get_collision_layer() == 512:
		die()
