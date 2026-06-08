extends CharacterBody2D

const LUNGHEZZA_RAGGIO = 50.0 
const SPEED = 200.0

@onready var suono_passi = $SuonoPassi
@onready var timer_passi = $TimerPassi
@onready var raggio = $RayCast2D
@onready var anim = $AnimatedSprite2D 
@onready var direction_pivot: Marker2D = $Direction
@onready var actionable_finder: Area2D = $Direction/ActionableFinder

# Introduciamo la variabile di stato
var is_in_dialogue: bool = false

func _ready():
	global.player = self
	
	if global.has_saved_position:
		# Spostiamo il player sulle vecchie coordinate
		global_position = global.map_return_position
		
		# Resettiamo subito il flag per i prossimi spostamenti standard
		global.has_saved_position = false
		print("ARCHITETTURA: Rientro completato. Player riposizionato a: ", global_position)
	
	# Manteniamo l'ascolto sul segnale di chiusura
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)

func _physics_process(_delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	# Se siamo in un dialogo, uccidiamo la velocità e interrompiamo il calcolo fisico
	if is_in_dialogue:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	if direction != Vector2.ZERO:
		# Usa il metodo nativo per calcolare l'angolo del vettore in radianti
		direction_pivot.rotation = direction.angle()
		velocity = direction * SPEED
		
		# --- GESTIONE ANIMAZIONI (Nomi sincronizzati con la tua foto) ---
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				anim.play("CamminataDX")
			else:
				anim.play("CamminataSX")
		else:
			if direction.y > 0:
				anim.play("CamminataGiù")
			else:
				anim.play("CamminataSU")
		
		raggio.target_position = direction * LUNGHEZZA_RAGGIO
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		# Il tuo omino fermo si chiama "fermo"
		anim.play("fermo")

	move_and_slide()
	
	# LOGICA AUDIO DEI PASSI
	# Controlliamo se il personaggio si sta muovendo fisicamente sulla mappa
	if velocity.length() > 0:
		# Se si muove e il timer ha finito il cooldown, è il momento di fare un passo
		if timer_passi.is_stopped():
			#print("IL CODICE FUNZIONA: STO RIPRODUCENDO L'AUDIO") # <-- AGGIUNGI QUESTO
			
			# UX Fondamentale: randomizziamo il pitch per non far impazzire il giocatore
			suono_passi.pitch_scale = randf_range(0.85, 1.15)
			suono_passi.play()
			
			# Facciamo ripartire il cooldown del timer
			timer_passi.start()
	else:
		# Se il giocatore si ferma di colpo, stoppiamo immediatamente l'audio residuo
		suono_passi.stop()

func raccogli_moneta():
	global.coin += 1
	print("Focaccia raccolta! Totale: ", global.coin)

func _unhandled_input(event: InputEvent) -> void:
	# Impediamo di premere "F" o interagire se stiamo già parlando
	if is_in_dialogue:
		return
		
	if event.is_action_pressed("interact"):
		# Estraiamo un array di tutte le Area2D che si sovrappongono al nostro radar
		var actionables = actionable_finder.get_overlapping_areas()
		
		if actionables.size() > 0:
			# Prendiamo il primo elemento trovato
			var target = actionables[0]
			
			# Programmazione difensiva: verifichiamo che sia un oggetto valido
			if target is Actionable:
				# 1. Cambiamo lo stato invece di mettere in pausa il mondo
				is_in_dialogue = true
				
				# 2. Lanciamo il dialogo
				target.action()
				
				# 3. Consumiamo l'input
				get_viewport().set_input_as_handled()

# Questa funzione viene invocata automaticamente dal plugin quando il dialogo si chiude
func _on_dialogue_ended(_resource: DialogueResource) -> void:
	# Liberiamo il giocatore
	is_in_dialogue = false

	# Se la stringa non è vuota, significa che un dialogo ha richiesto un minigioco
	if global.next_minigame_scene != "":
		# --- SALVATAGGIO COORDINATE DI RIENTRO ---
		global.map_return_position = global_position
		global.has_saved_position = true
		# -----------------------------------------
		
		# Copiamo il percorso in una variabile locale temporanea
		var scene_to_load: String = global.next_minigame_scene
		
		# Puliamo immediatamente il Singleton per i dialoghi futuri
		global.next_minigame_scene = ""
		
		# Carichiamo la scena in modo dinamico
		print("ARCHITETTURA: Avvio scalabile del minigioco -> ", scene_to_load)
		get_tree().change_scene_to_file(scene_to_load)
