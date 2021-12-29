extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
var quit = false

var player = null
var player_dead = false
var boss = null
var boss_trigger = false
var score = 0
var level_end = false
var level = 0
var checkpoint_reached = false
var boss_dead = false
var boss_start = false
var boss_beat = false
var ending = false

var level1_unlock = false
var level2_unlock = false
var level3_unlock = false
var level4_unlock = false
var level5_unlock = false

var show_options = false
var SFX_vol = 1
var music_vol = 1
var bloom = true
var fullscreen = true
var show_mouse = true

var previous_scene = ""

var file = File.new()

var data = {}

func _ready():
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var load_data = file.get_var()
			
			level1_unlock = load_data.level1
			level2_unlock = load_data.level2
			level3_unlock = load_data.level3
			level4_unlock = load_data.level4
			level5_unlock = load_data.level5
			
			bloom = load_data.bloom
			fullscreen = load_data.fullscreen
			SFX_vol = load_data.sfx
			music_vol = load_data.music
			show_mouse = load_data.mouse
			
			file.close()
	else:
		level1_unlock = false
		level2_unlock = false
		level3_unlock = false
		level4_unlock = false
		level5_unlock = false
		
		SFX_vol = 1
		music_vol = 1
		bloom = true
		fullscreen = true
		show_mouse = false
	

func _process(delta):
	if quit == true:
		data = {
			"level1": level1_unlock,
			"level2": level2_unlock,
			"level3": level3_unlock,
			"level4": level4_unlock,
			"level5": level5_unlock,
			"bloom": bloom,
			"fullscreen": fullscreen,
			"sfx": SFX_vol,
			"music": music_vol,
			"mouse": show_mouse
		}
		
		var dir = Directory.new()
		if !dir.dir_exists(Global.SAVE_DIR):
			dir.make_dir_recursive(Global.SAVE_DIR)
		
		var error = file.open(Global.save_path, File.WRITE)
		if error == OK:
			file.store_var(data)
			file.close()
			
		get_tree().quit()
		
	
	if show_mouse == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.set_mouse_mode(!Input.MOUSE_MODE_CAPTURED)
	elif show_mouse == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
