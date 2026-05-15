extends Node

@export var items_to_collect: int = 3
@export var has_time_limit: bool = false
@export var time_limit_seconds: float = 30.0

# Aggiungi il riferimento alla nuova Label
@onready var game_over_label: Label = %GameOverLabel

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
		
	var fire_barrier = get_tree().get_first_node_in_group("FireBarrierGroup")
	if fire_barrier:
		#print("LOG QUESTMANAGER: FireBarrier trovata! Connetto il segnale.")
		fire_barrier.player_burned.connect(_on_player_burned)

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
	# Ferma il timer per sicurezza
	if has_time_limit and not quest_timer.is_stopped():
		quest_timer.stop()
		
	# 1. Mostra il messaggio a schermo
	game_over_label.text = motivo
	game_over_label.show() # Rende visibile la Label
	
	# 2. Mette in pausa una funzione per 2.5 secondi (per far leggere il testo)
	# L'uso di 'await' è cruciale per non bloccare l'intero gioco
	await get_tree().create_timer(2.5).timeout
	
	# 3. Riavvia completamente la scena corrente (ripristina player, fuoco e timer)
	get_tree().reload_current_scene()

func _on_player_burned() -> void:
	# Il fuoco ti ha preso, chiamiamo la sconfitta con il messaggio specifico
	missione_fallita("Sei stato avvolto dalle fiamme!")
