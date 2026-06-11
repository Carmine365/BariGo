extends CanvasLayer # <-- QUESTA È LA RIGA CHE MANCA

func _ready() -> void:
	# Ora lo script eredita da Node, quindi get_tree() esiste
	get_tree().paused = true
	$ColorRect/CenterContainer/VBoxContainer/MarginContainer/Button.grab_focus()

func _on_button_pressed() -> void:
	get_tree().paused = false # Sblocca il gioco
	queue_free() # Elimina il popup e libera la memoria
