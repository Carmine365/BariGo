extends Camera2D

# Velocità di scorrimento verso sinistra (pixel al secondo)
@export var scroll_speed: float = 200.0
var active: bool = false

func _ready() -> void:
	# Centriamo la camera all'inizio, se necessario
	active = true

func _process(delta: float) -> void:
	if active:
		# Muove la camera verso sinistra sull'asse X
		position.x += scroll_speed * delta
