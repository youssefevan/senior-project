extends KinematicBody2D

var velocity = Vector2()
var grav = 1400
var speed = 25
var accel = 500

var motion = Vector2.ZERO
var left = Vector2(-1, 0)
var right = Vector2(1, 0)
var dir = left

func _process(delta):
	
	if is_on_wall():
		if dir == left:
			dir = right
		elif dir == right:
			dir = left
	
	velocity.y += grav * delta
	
	velocity.x += dir.x * accel * delta
	velocity.x = clamp(velocity.x, -speed, speed)
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	animate()

func animate():
	$Animator.play("move")
