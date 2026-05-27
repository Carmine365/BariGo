extends CanvasLayer

# Riferimenti ai nodi visivi dell'interfaccia
@export var dialogue_box: Panel # Il contenitore (lo sfondo del dialogo)
@export var text_label: Label # O RichTextLabel, dove stamperai il testo
@export var name_label: Label # <--- NUOVO RIFERIMENTO ALLA LABEL DEL NOME

var current_dialogue: Array[Dictionary] = []
var current_line_index: int = 0
var is_dialogue_active: bool = false

func _ready() -> void:
	# Il dialogo deve essere invisibile all'avvio del gioco
	if dialogue_box != null:
		dialogue_box.hide()

# Questa è la funzione esatta che l'NPC invoca
func start_dialogue(dialogue_data: Array[Dictionary]) -> void:
	if dialogue_data.is_empty():
		printerr("ERRORE: Dati dialogo vuoti passati a DialogueUI.")
		return
		
	current_dialogue = dialogue_data
	current_line_index = 0
	is_dialogue_active = true
	
	# Congeliamo il mondo di gioco (nemici, acqua, animazioni) mentre si parla
	get_tree().paused = true 
	
	dialogue_box.show()
	_show_current_line()

func _show_current_line() -> void:
	# Estraiamo il valore associato alla chiave "text" dal dizionario
	var linea_corrente: Dictionary = current_dialogue[current_line_index]

	# Estraiamo in modo sicuro il testo e il nome con la programmazione difensiva (.get)
	text_label.text = linea_corrente.get("text", "[Testo mancante]")
	name_label.text = linea_corrente.get("name", "Sconosciuto") # Se manca il nome, sarà 'Sconosciuto'
	
func _unhandled_input(event: InputEvent) -> void:
	if not is_dialogue_active:
		return
		
	if event.is_action_pressed("interact"):
		# Uccide l'evento per evitare salti doppi
		get_viewport().set_input_as_handled() 
		_advance_dialogue()

func _advance_dialogue() -> void:
	current_line_index += 1
	
	# Se ci sono ancora battute nell'array, mostriamo la successiva
	if current_line_index < current_dialogue.size():
		_show_current_line()
	else:
		_end_dialogue()

func _end_dialogue() -> void:
	is_dialogue_active = false
	dialogue_box.hide()
	current_dialogue.clear()
	
	# Fondamentale: sblocchiamo il mondo di gioco alla fine del dialogo
	get_tree().paused = false
