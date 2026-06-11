extends CanvasLayer

func _ready() -> void:
	if GameManager.intro_vista: # Se è già true, la cancello
		queue_free()
		return
	
	# Se arriva qui, è la prima volta: la setto a true
	GameManager.intro_vista = true 
	
	get_tree().paused = true
	$ColorRect/CenterContainer/VBoxContainer/MarginContainer/Button.grab_focus()

func _on_button_pressed() -> void:
	get_tree().paused = false # Sblocca il gioco (riprende il tempo)
	queue_free()              # Elimina la schermata di benvenuto
