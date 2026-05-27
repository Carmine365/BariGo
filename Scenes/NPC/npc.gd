extends Area2D

# 1. Non esportiamo più una Texture2D, ma uno SpriteFrames
@export var npc_frames: SpriteFrames

# 2. Aggiungiamo il nome dell'animazione di base da riprodurre
@export var idle_animation_name: String = "default"

var player_in_range: bool = false

# 3. Aggiorniamo il riferimento al nuovo tipo di nodo
# Assicurati che il nodo nella scena si chiami ESATTAMENTE "AnimatedSprite2D"
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	# 4. Assegniamo i frame e avviamo l'animazione
	if npc_frames != null:
		animated_sprite.sprite_frames = npc_frames
		animated_sprite.play(idle_animation_name)
		
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Il nodo è stato riconosciuto come Player!")
		player_in_range = true
	else:
		print("ATTENZIONE: Il nodo NON fa parte del gruppo 'Player'.")

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("interact"):
		# Uccide l'evento: nessun altro nodo saprà che abbiamo premuto F
		get_viewport().set_input_as_handled() 
		
