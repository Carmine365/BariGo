extends Node

# Salviamo i volumi separati
var volume_music: float = 0.5
var volume_sfx: float = 0.5

func set_bus_volume(bus_name: String, value: float):
	var bus_index = AudioServer.get_bus_index(bus_name)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	
	# Salviamo il valore così che sia disponibile ovunque
	if bus_name == "Music":
		volume_music = value
	elif bus_name == "SFX":
		volume_sfx = value

func get_bus_volume(bus_name: String) -> float:
	if bus_name == "Music":
		return volume_music
	elif bus_name == "SFX":
		return volume_sfx
	return 1.0
