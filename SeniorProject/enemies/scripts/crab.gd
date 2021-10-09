extends KinematicBody2D

var velocity = Vector2()
var grav = 1400
var speed = 25

var player_detected = false

var target = null
var target_pos = Vector2()

var dir_x

func apply_gravity(delta):
	velocity.y += grav * delta

func apply_movement():
	velocity = move_and_slide(velocity, Vector2.UP)

func sleep():
	velocity -= velocity

func _on_PlayerDetection_body_entered(body):
	if body.is_in_group("Player"):
		player_detected = true
		target = body

func _on_PlayerDetection_body_exited(body):
	if body.is_in_group("Player"):
		player_detected = false
		target = null
