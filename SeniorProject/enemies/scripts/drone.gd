extends KinematicBody2D

const exp_scene = preload("res://effects/Explosion1.tscn")

var velocity = Vector2(-50, 50)
var health = 2

func sprite_rotation():
	$Sprite.rotation_degrees += 3

func _process(delta):
	sprite_rotation()
	
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
	print(health)

func die():
	explode()
	call_deferred("free")

func explode():
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)
