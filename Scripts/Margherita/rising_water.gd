class_name RisingWater
extends Area2D

@export var rise_speed: float = 40.0
@onready var camera: Camera2D = $AutoScrollCamera

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	# Forza Godot a usare questa telecamera, ignorando quella del Player
	camera.make_current()

func _process(delta: float) -> void:
	# Sposta l'intera struttura (Acqua, Telecamera e Soffitto invisibile) verso l'alto
	position.y -= rise_speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		EventBus.player_touched_water.emit()
