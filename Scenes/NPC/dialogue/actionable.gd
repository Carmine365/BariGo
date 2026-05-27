extends Area2D
class_name Actionable

# Esponiamo la risorsa del file di dialogo (.dialogue) generata dal plugin
@export var dialogue_resource: DialogueResource

# Esponiamo il titolo del blocco da cui far partire la conversazione (es. "start")
@export var dialogue_start: String = "start"

const BalloonScene = preload("res://Scenes/NPC/dialogue/balloon.tscn")

# Questa funzione verrà invocata dal codice del Giocatore quando premerà "F"
func action() -> void:
	if dialogue_resource != null:
		var balloon_instance = BalloonScene.instantiate()
		
		# Aggiungiamo il nostro balloon all'albero della scena corrente
		get_tree().current_scene.add_child(balloon_instance)
		
		# AVVIO CORRETTO: Passiamo i dati al NOSTRO script, ignorando il default
		balloon_instance.start(dialogue_resource, dialogue_start)
	else:
		printerr("ERRORE: Nessuna risorsa DialogueResource assegnata a questo nodo Actionable: ", name)
