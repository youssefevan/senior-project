extends KinematicBody2D

const antic_scene = preload("res://effects/Rumble0.tscn")
const exp_scene = preload("res://effects/Explosion1.tscn")

onready var sfx = get_node("/root/Audio")

var player_detected = false
var velocity = Vector2()
var grav = 0

func _ready():
	player_detected = false
	grav = 0

func _process(delta):
	if player_detected == true:
		grav = 850
	elif player_detected == false:
		grav = 0
	
	velocity.y += grav * delta
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_Anticipation_area_entered(area):
	if area.get_collision_layer() == 1:
		var antic = antic_scene.instance()
		antic.position = position
		get_tree().get_root().call_deferred("add_child", antic)

func _on_PlayerDetection_area_entered(area):
	if area.get_collision_layer() == 1:
		player_detected = true

func _on_CollisionDetection_body_entered(body):
	if body.get_collision_layer() == 1 or body.get_collision_layer() == 2  or body.get_collision_layer() == 4 or body.get_collision_layer() == 512:
		hit()

func hit():
	explode()
	call_deferred("free")

func explode():
	sfx.edeath.play()
	var explosion = exp_scene.instance()
	explosion.position = position
	get_tree().get_root().call_deferred("add_child", explosion)
