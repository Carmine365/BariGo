extends CanvasLayer

@onready var test_label = $Sfondo/RichTextLabel

func _ready() -> void:
	# Il taccuino parte sempre nascosto
	visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("apri_taccuino"):
		# Invertiamo la visibilità (se è true diventa false, e viceversa)
		visible = !visible
		
		# Se lo stiamo aprendo, aggiorniamo il testo e fermiamo il gioco
		if visible:
			test_label.text = global.diario_storico
			# Opzionale: se vuoi mettere il gioco in pausa mentre leggi
			get_tree().paused = true
		else:
			get_tree().paused = false
