extends Node

# Riferimenti ai bus audio
var music_bus := AudioServer.get_bus_index("Music")
var sfx_bus := AudioServer.get_bus_index("SFX")

# Valori predefiniti (in DB)
const DEFAULT_MUSIC_VOLUME_DB = -10.0
const DEFAULT_SFX_VOLUME_DB = -5.0

func _ready():
	# Carica impostazioni salvate
	load_volume_settings()

func set_music_volume_db(value_db: float):
	AudioServer.set_bus_volume_db(music_bus, value_db)
	save_volume_settings()

func set_sfx_volume_db(value_db: float):

	AudioServer.set_bus_volume_db(sfx_bus, value_db)
	save_volume_settings()

func set_music_volume_linear(value_linear: float):
	var db_value = linear_to_db(value_linear)
	set_music_volume_db(db_value)

func set_sfx_volume_linear(value_linear: float):
	var db_value = linear_to_db(value_linear)
	set_sfx_volume_db(db_value)

func get_music_volume_linear() -> float:
	var db = AudioServer.get_bus_volume_db(music_bus)
	return db_to_linear(db)

func get_sfx_volume_linear() -> float:
	var db = AudioServer.get_bus_volume_db(sfx_bus)
	return db_to_linear(db)

func get_music_volume_db() -> float:
	return AudioServer.get_bus_volume_db(music_bus)

func get_sfx_volume_db() -> float:
	return AudioServer.get_bus_volume_db(sfx_bus)

func save_volume_settings():
	var config = ConfigFile.new()
	config.set_value("audio", "music_volume_db", get_music_volume_db())
	config.set_value("audio", "sfx_volume_db", get_sfx_volume_db())
	config.save("user://settings.cfg")

func load_volume_settings():
	var config = ConfigFile.new()
	if config.load("user://settings.cfg") == OK:
		var music_vol_db = config.get_value("audio", "music_volume_db", DEFAULT_MUSIC_VOLUME_DB)
		var sfx_vol_db = config.get_value("audio", "sfx_volume_db", DEFAULT_SFX_VOLUME_DB)
		
		set_music_volume_db(music_vol_db)
		set_sfx_volume_db(sfx_vol_db)
	else:
		# Prima esecuzione: imposta i valori predefiniti
		set_music_volume_db(DEFAULT_MUSIC_VOLUME_DB)
		set_sfx_volume_db(DEFAULT_SFX_VOLUME_DB)
