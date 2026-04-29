extends Node2D

var npc = CharacterBody2D.new()
# Invece di Dialogue, usiamo un Label (che è un testo semplice)
@onready var label_dialogo = Label.new()

func _ready():
	npc.position = Vector2(100, 100)
	add_child(npc)
	
	# Prepariamo il testo ma lo teniamo nascosto all'inizio
	add_child(label_dialogo)
	label_dialogo.hide() 
	label_dialogo.position = Vector2(100, 80) # Sopra la testa dell'NPC

func _process(delta):
	if Input.is_action_just_pressed("click"): # Meglio 'just_pressed' per un singolo click
		label_dialogo.text = "Ciao, come posso aiutarti?"
		label_dialogo.show()
