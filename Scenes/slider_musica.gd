extends HSlider

@export var bus_name: String = "Music"

func _ready() -> void:
	# Collega il segnale una sola volta
	value_changed.connect(_on_value_changed)
	
	# AGGIUNGI QUESTO: aggiorna il valore non solo al ready, 
	# ma anche ogni volta che il nodo entra nell'albero (es. quando apri il menu)
	visibility_changed.connect(_on_visibility_changed)
	
	# Chiamata iniziale
	_update_slider_value()

func _on_visibility_changed():
	if visible: # Quando il menu si apre e diventa visibile
		_update_slider_value()

func _update_slider_value():
	value = AudioGlobal.get_bus_volume(bus_name)

func _on_value_changed(new_value: float) -> void:
	AudioGlobal.set_bus_volume(bus_name, new_value)
