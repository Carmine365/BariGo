extends CanvasLayer

@onready var sfondo = $Sfondo
@onready var test_label = $Sfondo/RichTextLabel
@onready var notifica_toast = $NotificaToast
@onready var suono_apertura = $SuonoApertura # 1. Riferimento al nodo audio
@onready var suono_chiusura = $SuonoChiusura # 1. Riferimento al nodo audio
@onready var suono_notifica = $SuonoNotifica

func _ready() -> void:
	# Nascondiamo solo il pannello del diario, non il CanvasLayer
	sfondo.visible = false
	
	# Assicuriamoci che la notifica parta invisibile
	notifica_toast.modulate.a = 0.0
	
	# Il Frontend si iscrive al segnale del Backend
	global.appunto_aggiunto.connect(_mostra_notifica)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("apri_taccuino"):
		# Invertiamo la visibilità solo dello sfondo scuro
		sfondo.visible = !sfondo.visible
		
		if sfondo.visible:
			test_label.text = global.diario_storico
			# 2. Riproduciamo il suono prima di mettere in pausa
			suono_apertura.play()
			get_tree().paused = true
		else:
			suono_chiusura.play()
			get_tree().paused = false

func _mostra_notifica() -> void:
	# 2. Riproduciamo il suono prima di far partire l'animazione visiva
	suono_notifica.play()
	
	# Creiamo un'animazione interpolata (Tween) nativa di Godot 4
	var tween = create_tween()
	
	# 1. Dissolvenza in entrata (0.5 secondi)
	tween.tween_property(notifica_toast, "modulate:a", 1.0, 0.5)
	
	# 2. Manteniamo a schermo la notifica (3.0 secondi)
	tween.tween_interval(3.0)
	
	# 3. Dissolvenza in uscita (0.5 secondi)
	tween.tween_property(notifica_toast, "modulate:a", 0.0, 0.5)
