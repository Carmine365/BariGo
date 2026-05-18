class_name LevelManager
extends Node

@export var items_to_collect: int = 3
@export var game_over_label: Label
@export var counter_label: Label # <-- Nuova dipendenza per la UI in gioco
@export var next_level: PackedScene

var current_items: int = 0

func _ready() -> void:
	# Il manager si mette in ascolto del segnale globale
	EventBus.item_collected.connect(_on_item_collected)
	
	# Inizializza la UI a zero
	_update_counter_ui()

func _on_item_collected(_item_name: String) -> void:
	current_items += 1
	_update_counter_ui()

func _update_counter_ui() -> void:
	if counter_label != null:
		# Mostra il progresso in formato "Raccolti: 1 / 5"
		counter_label.text = "Oggetti raccolti: " + str(current_items) + " / " + str(items_to_collect)

func check_level_completion() -> void:
	if current_items >= items_to_collect:
		_trigger_victory()
	else:
		var mancanti: int = items_to_collect - current_items
		print("Ti mancano ancora " + str(mancanti) + " fusibili!")

func _trigger_victory() -> void:
	print("VITTORIA INNESCATA!")
	
	if game_over_label != null:
		game_over_label.text = "Vittoria, livello completato!"
		game_over_label.show()
		
	get_tree().paused = true
	await get_tree().create_timer(3.0, true).timeout
	get_tree().paused = false
	
	if next_level != null:
		get_tree().change_scene_to_packed(next_level)
	else:
		printerr("ERRORE: Nessuna scena successiva configurata nel LevelManager.")
