extends CanvasLayer

@onready var sfx_click = $SfxClick
@export var btn_riprendi: Button
@onready var contenitore_bottoni = $ColorRect/MarginContainer/Menupausa
@onready var pannello_opzioni = $ColorRect/PannelloOpzioni2

func _ready() -> void:
	hide()
	if pannello_opzioni:
		pannello_opzioni.hide()
		# Colleghiamo il tasto Indietro UNA SOLA VOLTA
		var btn_indietro = pannello_opzioni.find_child("BtnIndietro", true, false)
		if btn_indietro:
			btn_indietro.pressed.connect(chiudi_opzioni)
	
	for nodo in contenitore_bottoni.get_children():
		if nodo is Button:
			nodo.mouse_entered.connect(_ruba_focus_col_mouse.bind(nodo))

func _ruba_focus_col_mouse(bottone_toccato: Button) -> void:
	bottone_toccato.grab_focus()

func _input(event: InputEvent) -> void:
	# _input gira anche se il gioco è in pausa, perfetto.
	if visible:
		if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down"):
			var focus_attuale = get_viewport().gui_get_focus_owner()
			if focus_attuale == null:
				btn_riprendi.grab_focus()
				get_viewport().set_input_as_handled()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if pannello_opzioni and pannello_opzioni.visible:
			chiudi_opzioni()
		else:
			_toggle_pause()
		get_viewport().set_input_as_handled()

func _toggle_pause() -> void:
	var nuovo_stato_pausa = not get_tree().paused
	get_tree().paused = nuovo_stato_pausa
	visible = nuovo_stato_pausa
	if visible:
		contenitore_bottoni.show()
		if pannello_opzioni: pannello_opzioni.hide()
		btn_riprendi.grab_focus()

func _on_btn_riprendi_pressed() -> void:
	sfx_click.play()
	_toggle_pause()

func _on_btn_esci_pressed() -> void:
	sfx_click.play()
	
	# 1. Togliamo la pausa prima di cambiare scena
	get_tree().paused = false
	
	# 2. Nascondiamo esplicitamente il menu
	hide()
	
	# 3. Opzionale ma consigliato: riportiamo il menu allo stato iniziale
	# (così se rientri in gioco il menu è pulito)
	if pannello_opzioni:
		pannello_opzioni.hide()
	if contenitore_bottoni:
		contenitore_bottoni.show()
	
	# 4. Ora cambiamo scena
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_btn_opzioni_pressed() -> void:
	sfx_click.play()
	if pannello_opzioni:
		contenitore_bottoni.hide()
		pannello_opzioni.show()
		# Focus sul tasto indietro appena aperto
		var btn = pannello_opzioni.find_child("BtnIndietro", true, false)
		if btn: btn.grab_focus()

func chiudi_opzioni() -> void:
	if pannello_opzioni:
		pannello_opzioni.hide()
	contenitore_bottoni.show()
	btn_riprendi.grab_focus()
