extends Area2D

# Tipizzazione forte: ora Godot sa che questo deve essere un LevelManager, non un nodo a caso
@export var manager: LevelManager

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# 1. Usa i gruppi per identificare il giocatore, non il nome
	if body.is_in_group("Player"):
		
		# 2. Controllo robusto del riferimento
		if manager == null:
			printerr("ERRORE CRITICO: LevelManager non assegnato nell'Area di uscita.")
			return
			
		# 3. Delega la logica al manager. Niente stringhe magiche.
		manager.check_level_completion()
