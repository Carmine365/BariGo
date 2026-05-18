extends Label

var counter: int = 0

func _ready() -> void:
	# Connette il segnale globale a questo nodo
	EventBus.item_collected.connect(_on_item_collected)
	# Inizializza il testo
	_update_text()

func _on_item_collected(_collected_item_name: String) -> void:
	# Se in futuro vorrai filtrare per item_name (es. contare solo le monete), 
	# potrai farlo qui inserendo un blocco if.
	counter += 1
	_update_text()

func _update_text() -> void:
	text = "Oggetti raccolti: " + str(counter)
