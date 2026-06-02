class_name LevelManager
extends Node

@export var items_to_collect: int = 3
@export var game_over_label: Label
@export var counter_label: Label
@export var next_level: PackedScene

var current_items: int = 0

func _ready() -> void:
	EventBus.item_collected.connect(_on_item_collected)
	_update_counter_ui()
	if game_over_label: game_over_label.hide()

func _on_item_collected(_item_name: String) -> void:
	current_items += 1
	_update_counter_ui()

func _update_counter_ui() -> void:
	if counter_label != null:
		counter_label.text = "Fusibili raccolti: " + str(current_items) + " / " + str(items_to_collect)

# Questa è la funzione che chiama la porta
func check_level_completion() -> bool:
	if current_items >= items_to_collect:
		_trigger_victory()
		return true # La porta dice "OK, puoi passare"
	else:
		var mancanti: int = items_to_collect - current_items
		print("La porta è chiusa! Ti mancano ancora " + str(mancanti) + " fusibili!")
		return false # La porta dice "NO"

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
		printerr("ERRORE: Nessuna scena successiva configurata.")
