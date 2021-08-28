extends Camera2D

#const LOOK_AHEAD = 0.07
#const SHIFT_TRANS = Tween.TRANS_SINE
#const SHIFT_EASE = Tween.EASE_OUT
#const SHIFT_DURTION = .5

#onready var prev_cam_pos = get_camera_position()
#onready var shift_tween = $"ShiftTween"

export (NodePath) var target_nodepath = null
var target_node
var smooth_speed = .5

#var facing = 0

func _ready():
	target_node = get_node(target_nodepath)

func _physics_process(delta):
	
	#print(target_node.global_position.x - $LookLeft.global_position.x, target_node.global_position.x - $LookRight.global_position.x)
	
	
		
	self.global_position = lerp(self.global_position, target_node.global_position, smooth_speed)
	
	
	#self.global_position = target_node.global_position
	
	#check_facing()
	#print(facing)
	#prev_cam_pos = get_camera_position()

#func check_facing():
	
#	var new_facing = sign(get_camera_position().x - prev_cam_pos.x)
#	if new_facing != 0 && facing != new_facing:
#		facing = new_facing
#		
#		var target_offset = get_viewport_rect().size.x * LOOK_AHEAD * facing
#		
#		shift_tween.interpolate_property(self, "position:x", position.x, target_offset, SHIFT_DURTION, SHIFT_TRANS, SHIFT_EASE)
#		shift_tween.start()


#func _on_Player_grounded_update(is_grounded):
#	drag_margin_v_enabled = !is_grounded
