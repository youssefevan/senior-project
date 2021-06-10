extends Camera2D

const LOOK_AHEAD = 0.07
const SHIFT_TRANS = Tween.TRANS_LINEAR
const SHIFT_EASE = Tween.EASE_OUT
const SHIFT_DURTION = .5

onready var prev_cam_pos = get_camera_position()
onready var shift_tween = $"shift-tween"

var facing = 0
var large_y_limits = false

func _on_player_large_y_limits():
	large_y_limits = true

func _process(delta):
	check_facing()
	prev_cam_pos = get_camera_position()

func check_facing():
	var new_facing = sign(get_camera_position().x - prev_cam_pos.x)
	if new_facing != 0 && facing != new_facing:
		facing = new_facing
		var target_offset = get_viewport_rect().size.x * LOOK_AHEAD * facing
		
		shift_tween.interpolate_property(self, "position:x", position.x, target_offset, SHIFT_DURTION, SHIFT_TRANS, SHIFT_EASE)
		shift_tween.start()

func _on_player_grounded_update(is_grounded):
	drag_margin_v_enabled = !is_grounded
