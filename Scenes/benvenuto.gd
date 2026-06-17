extends CanvasLayer

# Memorizziamo il percorso del bottone per comodità
@onready var bottone_inizia: Button = $ColorRect/CenterContainer/VBoxContainer/MarginContainer/Button

func _ready() -> void:
	if GameManager.intro_vista: 
		hide() # IMPORTANTE: usiamo hide() invece di queue_free() così lo script resta vivo per dopo
		return
	
	# Se è la prima volta in assoluto:
	GameManager.intro_vista = true 
	_apri_schermata()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Schermata Informazioni"):
		if visible:
			_chiudi_schermata()
		else:
			_apri_schermata()

func _on_button_pressed() -> void:
	_chiudi_schermata()

# Funzione riutilizzabile per aprire il menu e mettere in pausa
func _apri_schermata() -> void:
	show()
	get_tree().paused = true
	bottone_inizia.grab_focus() # Ridà il focus al bottone per chi usa la tastiera

# Funzione riutilizzabile per chiudere il menu e riprendere il gioco
func _chiudi_schermata() -> void:
	get_tree().paused = false # Sblocca il gioco
	hide() # Nasconde semplicemente lo schermo invece di distruggerlo
