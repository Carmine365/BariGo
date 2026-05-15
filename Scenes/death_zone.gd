extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if body.has_method("die"):
			body.die()
			
		# Cerchiamo il QuestManager per comunicare la sconfitta
		var quest_manager = get_node_or_null("../../QuestManager") # Aggiusta il percorso se necessario
		if quest_manager:
			quest_manager.missione_fallita("Sei precipitato nel vuoto!")
