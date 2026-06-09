extends CanvasLayer

@onready var sfx_click = $SfxClick
@export var btn_riprendi: Button

func _ready() -> void:
	# All'avvio il menu deve essere rigorosamente nascosto
	hide()

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
	if visible:
		btn_riprendi.grab_focus()

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
