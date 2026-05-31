extends Area2D
var velocita = 300
func _process(delta):
	position.x -= velocita * delta
