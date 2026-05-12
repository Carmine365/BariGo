extends Node

@export var items_to_collect: int = 3
@export var has_time_limit: bool = false
@export var time_limit_seconds: float = 30.0

var current_items: int = 0
@onready var quest_timer: Timer = $Timer

@onready var time_label: Label = %TimeLabel # Assicurati di aver creato questo nodo

func _process(delta: float) -> void:
	if has_time_limit and not quest_timer.is_stopped():
		# Mostra il tempo rimanente arrotondato al secondo
		time_label.text = str(int(quest_timer.time_left))

func _ready() -> void:
	# Configurazione del timer se necessario
	if has_time_limit:
		quest_timer.wait_time = time_limit_seconds
		quest_timer.one_shot = true
		quest_timer.timeout.connect(_on_timer_timeout)
		quest_timer.start()

	# Cerchiamo tutti gli oggetti nella scena e connettiamo i segnali
	# (Presuppone che abbiate messo i CollectibleItem in un gruppo "Collectibles")
	var collectibles = get_tree().get_nodes_in_group("Collectibles")
	for item in collectibles:
		item.item_collected.connect(_on_item_collected)

func _on_item_collected() -> void:
	current_items += 1
	print("Raccolto: ", current_items, "/", items_to_collect)
	
	if current_items >= items_to_collect:
		missione_completata()

func _on_timer_timeout() -> void:
	missione_fallita("Tempo scaduto!")

func missione_completata() -> void:
	if has_time_limit:
		quest_timer.stop()
	print("Missione completata con successo!")
	# Qui invierete il segnale al Singleton globale per salvare i progressi
	# es: GlobalData.mark_quest_complete("petruzzelli")

func missione_fallita(motivo: String) -> void:
	print("Missione fallita: ", motivo)
	# Qui gestite il respawn o il game over
