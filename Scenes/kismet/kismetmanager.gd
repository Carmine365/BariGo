extends Node

@export var nodo_teatro: Node2D 
@export var scritta_vittoria: Label
# Trascina qui nell'ispettore le 6 label della scritta KISMET in ordine!
@export var lettere_ui: Array[Label] 

var lettere_raccolte: int = 0

func registra_lettera(nome_lettera: String) -> void:
	# 1. Accendi la lettera corrispondente (es. se nome_lettera è "1", accendi lettere_ui[0])
	var indice = int(nome_lettera) - 1
	if indice >= 0 and indice < lettere_ui.size():
		# Cambiamo colore da grigio a GIALLO acceso per "accenderla"
		lettere_ui[indice].modulate = Color.YELLOW 
	
	# ... (il resto del codice che fa apparire il teatro rimane uguale) ...
	
	# 2. Controllo teatro e scritta finale
	if nodo_teatro and nodo_teatro.has_node("Teatro" + nome_lettera):
		var fetta = nodo_teatro.get_node("Teatro" + nome_lettera) as Sprite2D
		var tween = create_tween()
		tween.tween_property(fetta, "modulate:a", 1.0, 1.5)
	
	lettere_raccolte += 1
	if lettere_raccolte >= 6:
		# Appare la scritta di vittoria
		if scritta_vittoria:
			var tween_scritta = create_tween()
			tween_scritta.tween_property(scritta_vittoria, "modulate:a", 1.0, 2.0)
