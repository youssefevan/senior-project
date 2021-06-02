extends Camera2D

const LOOK_AHEAD = 0.15
const SHIFT_TRANS = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
const SHIFT_DURTION = 1

onready var prev_cam_pos = get_camera_position()
onready var tween = $"shift-tween"

var facing = 0

func _process(delta):
	check_facing()
	prev_cam_pos = get_camera_position()

func check_facing():
	var new_facing = sign(get_camera_position().x - prev_cam_pos.x)
	if new_facing != 0 && facing != new_facing:
		facing = new_facing
		var target_offset = get_viewport_rect().size.x * LOOK_AHEAD * facing
		
		tween.interpolate_property(self, "position:x", position.x, target_offset, SHIFT_DURTION, SHIFT_TRANS, SHIFT_EASE)
		tween.start()


func _on_player_grounded_update(is_grounded):
	drag_margin_v_enabled = !is_grounded
