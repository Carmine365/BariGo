extends Area2D

signal player_burned

func _ready() -> void:
	# Connetti il segnale di collisione
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	# Se il player tocca questa zona, muore
	if body.is_in_group("Player"):
		player_burned.emit()
