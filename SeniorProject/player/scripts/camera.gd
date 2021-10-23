extends Camera2D

export (NodePath) var target_nodepath = null
var target_node
var smooth_speed = 0.5
var drag_speed = 0.1
var drag_top = 0.6
var drag_bottom = 0.18

var player_pos = Vector2.ZERO

var top = 0
var bottom = 0
var left = 0
var right = 0

var prev_limit_top = 0
var prev_limit_bottom = 0
var prev_limit_left = 0
var prev_limit_right = 0

var p_dead = false
var p_dead_pos = Vector2()

func _ready():
	target_node = get_node(target_nodepath)
	p_dead = false
	pass

func _on_Player_dead(dead_pos):
	p_dead = true
	p_dead_pos = dead_pos

func _process(delta):
	if p_dead == false:
		self.global_position = lerp(self.global_position, target_node.global_position, smooth_speed)
	elif p_dead == true:
		self.global_position = p_dead_pos

func _on_Player_camera_room(cr_size, cr_pos):
	top = cr_pos.y - cr_size.y
	left = cr_pos.x - cr_size.x
	bottom = (top) + (cr_size.y * 2)
	right = (left) + (cr_size.x * 2)
	
	self.limit_top = top
	self.limit_left = left
	self.limit_bottom = bottom
	self.limit_right = right

func _on_Player_grounded():
	drag_margin_top = lerp(drag_margin_top, 0, drag_speed)
	#drag_margin_bottom = lerp(drag_margin_bottom, 0, drag_speed)
	
	
	#drag_margin_v_enabled = false

func _on_Player_not_grounded():
	drag_margin_top = lerp(drag_margin_top, drag_top, drag_speed)
	#drag_margin_bottom = lerp(drag_margin_bottom, drag_bottom, drag_speed)
	
	
	#drag_margin_v_enabled = true
