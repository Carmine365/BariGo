extends Node

@export var nodo_teatro: Node2D 

var lettere_raccolte: int = 0
const TOTALE_LETTERE: int = 6

func registra_lettera(nome_lettera: String) -> void:
	lettere_raccolte += 1
	
	# Traduciamo la lettera nel numero corrispondente al nome del nodo
	var numero_fetta = ""
	match nome_lettera:
		"K": numero_fetta = "1"
		"I": numero_fetta = "2"
		"S": numero_fetta = "3"
		"M": numero_fetta = "4"
		"E": numero_fetta = "5"
		"T": numero_fetta = "6"
	
	# Ora il nome cercato sarà "Teatro1", "Teatro2", ecc.
	var nome_fetta = "Teatro" + numero_fetta 
	
	if nodo_teatro and nodo_teatro.has_node(nome_fetta):
		var fetta = nodo_teatro.get_node(nome_fetta) as Sprite2D
		
		if fetta:
			var tween = create_tween()
			tween.tween_property(fetta, "modulate:a", 1.0, 1.5)
			print("Metamorfosi attivata per: ", nome_fetta)
	else:
		print("Errore: Non trovo il nodo chiamato: ", nome_fetta)
	
	if lettere_raccolte == TOTALE_LETTERE:
		print("Vittoria!")
