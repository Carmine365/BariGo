extends Area2D

@export var range_movimento: float = 100.0
@export var velocita: float = 2.0

func _ready():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - range_movimento, velocita).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "position:y", position.y + range_movimento, velocita).set_trans(Tween.TRANS_SINE)

	

func _on_body_entered(body):
	if body.name == "player1":
		body.global_position = Vector2(0,0)
		
		print ("hai colpito una nota! Ricominci da capo.")
