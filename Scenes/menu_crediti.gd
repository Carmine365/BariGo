extends Control

func _on_btn_indietro_pressed():
	# Distrugge la scena dei crediti e ricarica il menu principale
	# ATTENZIONE: Sostituisci il percorso con quello reale del tuo menu principale
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
