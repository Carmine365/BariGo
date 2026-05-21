class_name RisingWater
extends Area2D

@export var rise_speed: float = 70.0
@onready var camera: Camera2D = $AutoScrollCamera

var ferma: bool = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	camera.make_current()

func _process(delta: float) -> void:
	if not ferma:
		position.y -= rise_speed * delta

# Questa funzione viene chiamata direttamente dalla bandierina
func stop_acqua():
	ferma = true
	set_deferred("monitoring", false)
	
	# DISATTIVIAMO IL KILLER: Spegne l'area che fa perdere il giocatore
	if has_node("CadeinAcqua"):
		get_node("CadeinAcqua").set_deferred("monitoring", false)
	
	print("ACQUA E RIGRADO DI MORTE CONGELATI!")

func _on_body_entered(body: Node2D) -> void:
	if ferma: 
		return
	if body.is_in_group("Player"):
		EventBus.player_touched_water.emit()
