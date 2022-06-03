extends Node

const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
var quit = false

onready var music = get_node("/root/Music")

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
var level6_unlock = false

var level6_beat = false

var show_options = false
var SFX_vol = 1
var music_vol = 1
var bloom = true
var fullscreen = true
var show_mouse = true

var enable_particles = true

var previous_scene = ""

var file = File.new()

var data = {}

func _ready():
	init_steam()
	
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var load_data = file.get_var()
			
			level1_unlock = load_data.level1
			level2_unlock = load_data.level2
			level3_unlock = load_data.level3
			level4_unlock = load_data.level4
			level5_unlock = load_data.level5
			#print(load_data)
			if load_data.has("level6_unlock"):
				level6_unlock = load_data.level6
			else:
				level6_unlock = false
			
			if load_data.has("level6_beat"):
				level6_beat = load_data.level6_beat
			else:
				level6_beat = false
			
			bloom = load_data.bloom
			fullscreen = load_data.fullscreen
			SFX_vol = load_data.sfx
			music_vol = load_data.music
			show_mouse = load_data.mouse
			
			print(load_data)
			
			if load_data.has("enabled_particles"):
				enable_particles = load_data.enable_particles
			else:
				enable_particles = true
			
			file.close()
	else:
		level1_unlock = false
		level2_unlock = false
		level3_unlock = false
		level4_unlock = false
		level5_unlock = false
		level6_unlock = false
		level6_beat = false
		
		SFX_vol = 1
		music_vol = .6
		bloom = true
		fullscreen = false
		show_mouse = false
		enable_particles = true
	
	yield(get_tree().create_timer(.75), "timeout")
	if !music.theme.playing:
		music.theme.play()
	

func init_steam():
	var INIT: Dictionary = Steam.steamInit()
	print("Did Steam initialize?: "+str(INIT))
	
	Steam.connect("current_stats_received", self, "_steam_Stats_Ready")
	
#	if INIT['status'] != 1:
#		print("Failed to initialize Steam. "+str(INIT['verbal'])+" Shutting down...")
#		get_tree().quit()

func _process(delta):
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), SFX_vol)
	#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_vol)
	
	if quit == true:
		save()
		get_tree().quit()
	
	if show_mouse == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		#Input.set_mouse_mode(!Input.MOUSE_MODE_CAPTURED)
	elif show_mouse == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if level1_unlock:
		Steam.setAchievement("level1")
		Steam.storeStats()
	
	if level2_unlock:
		Steam.setAchievement("level2")
		Steam.storeStats()
	
	if level3_unlock:
		Steam.setAchievement("level3")
		Steam.storeStats()
	
	if level4_unlock:
		Steam.setAchievement("level4")
		Steam.storeStats()
	
	if level5_unlock:
		Steam.setAchievement("level5")
		Steam.storeStats()
	
	if boss_beat:
		#print(boss_beat)
		Steam.setAchievement("beat_boss")
		Steam.storeStats()
	
	if level6_beat:
		Steam.setAchievement("level6")
		Steam.storeStats()

func save():
	data = {
		"level1": level1_unlock,
		"level2": level2_unlock,
		"level3": level3_unlock,
		"level4": level4_unlock,
		"level5": level5_unlock,
		"level6": level6_unlock,
		"level6_beat": level6_beat,
		"bloom": bloom,
		"fullscreen": fullscreen,
		"sfx": SFX_vol,
		"music": music_vol,
		"mouse": show_mouse,
		"enable_particles": enable_particles
	}
	
	var dir = Directory.new()
	if !dir.dir_exists(Global.SAVE_DIR):
		dir.make_dir_recursive(Global.SAVE_DIR)
	
	var error = file.open(Global.save_path, File.WRITE)
	if error == OK:
		file.store_var(data)
		file.close()
