extends CanvasLayer

@onready var sfx_click = $SfxClick
@export var btn_riprendi: Button
@onready var contenitore_bottoni = $ColorRect/MarginContainer/VBoxContainer

func _ready() -> void:
	# All'avvio il menu deve essere rigorosamente nascosto
	hide()
	
	# Cicliamo tutti i nodi figli all'interno del contenitore
	for nodo in contenitore_bottoni.get_children():
		# Filtriamo l'esecuzione: applichiamo la logica solo se il nodo è un pulsante
		if nodo is Button:
			# Colleghiamo il segnale nativo del mouse alla nostra funzione personalizzata.
			# Usiamo .bind(nodo) per passare l'identità di quel preciso bottone alla funzione.
			nodo.mouse_entered.connect(_ruba_focus_col_mouse.bind(nodo))

func _input(event: InputEvent) -> void:
	# Eseguiamo il controllo solo se il menu di pausa è effettivamente a schermo
	if visible:
		# Controlliamo se l'utente ha premuto freccia SU o freccia GIÙ
		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			
			# Verifichiamo se il motore grafico ha già un nodo con il focus attivo
			var focus_attuale = get_viewport().gui_get_focus_owner()
			
			# Se nessun bottone ha il focus, lo forziamo sul pulsante "Riprendi"
			if focus_attuale == null:
				btn_riprendi.grab_focus()
				
				# Diciamo all'engine che l'input è stato gestito, evitando comportamenti anomali
				get_viewport().set_input_as_handled()

# Funzione che viene chiamata in automatico quando il mouse tocca un pulsante
func _ruba_focus_col_mouse(bottone_toccato: Button) -> void:
	# Il mouse è appena passato su questo bottone. 
	# Gli forziamo il focus esclusivo, togliendolo istantaneamente alla tastiera.
	bottone_toccato.grab_focus()

func _unhandled_input(event: InputEvent) -> void:
	# Usiamo l'azione nativa "ui_cancel" (tasto ESC)
	# Assicurati di non consumare l'input se sei in un campo di testo
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()
		get_viewport().set_input_as_handled()

func _toggle_pause() -> void:
	# Invertiamo lo stato logico del motore di pausa
	var nuovo_stato_pausa = not get_tree().paused
	get_tree().paused = nuovo_stato_pausa
	
	# La visibilità del menu deve riflettere lo stato della pausa
	visible = nuovo_stato_pausa
	
	# Seleziona automaticamente il primo bottone quando si apre la pausa
	#if visible:
	#	btn_riprendi.grab_focus()

func _on_btn_riprendi_pressed() -> void:
	sfx_click.play()
	# Cliccare "Riprendi" fa esattamente la stessa cosa di premere di nuovo ESC
	_toggle_pause()

func _on_btn_esci_pressed() -> void:
	sfx_click.play()
	# 1. Nascondi fisicamente il pannello prima di fare qualsiasi cosa
	hide() 
	
	# 2. Togli il blocco logico al motore grafico
	get_tree().paused = false
	
	# Qui inserisci il percorso esatto della tua scena del Menu Principale
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
