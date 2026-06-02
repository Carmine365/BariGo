extends Area2D

@export var sprite_chiusa: Sprite2D
@export var sprite_aperta: Sprite2D
@export var manager: LevelManager

func _ready():
	# All'avvio, mostra solo quella chiusa
	sprite_chiusa.visible = true
	sprite_aperta.visible = false

func _process(_delta):
	# Se il manager dice che abbiamo raggiunto gli oggetti, scambiamo gli sprite
	if manager and manager.current_items >= manager.items_to_collect:
		sprite_chiusa.visible = false
		sprite_aperta.visible = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		if manager != null:
			manager.check_level_completion()
