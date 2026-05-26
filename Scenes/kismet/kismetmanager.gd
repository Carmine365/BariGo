extends Node

# Questo serve a collegare la cartella del Teatro dall'Ispettore
@export var nodo_teatro: Node2D 

var lettere_raccolte: int = 0
const TOTALE_LETTERE: int = 6

func _ready() -> void:
	# Controllo di sicurezza all'avvio del livello
	if not nodo_teatro:
		push_error("ERRORE: Non hai trascinato il nodo 'Teatro' nell'Ispettore del Kismet Manager!")
	else:
		print("Kismet Manager pronto. Il teatro è nascosto e in attesa delle lettere...")

# Questa funzione verrà chiamata da OGNI lettera quando il player la raccoglie
func registra_lettera(nome_lettera: String) -> void:
	lettere_raccolte += 1
	print("Lettera ricevuta dal Manager: ", nome_lettera, " (", lettere_raccolte, "/6)")
	
	# Costruiamo il nome esatto del nodo (es. "Fetta_K", "Fetta_I")
	var nome_fetta = "Lettera" + nome_lettera
	
	# Controlliamo se dentro il nodo Teatro esiste questa fetta
	if nodo_teatro and nodo_teatro.has_node(nome_fetta):
		var fetta = nodo_teatro.get_node(nome_fetta) as Sprite2D
		
		if fetta:
			# Creiamo un'animazione fluida (Tween) che rimette l'Alpha a 1 in 1.5 secondi
			var tween = create_tween()
			tween.tween_property(fetta, "modulate:a", 1.0, 1.5)
			print("Metamorfosi attivata per: ", nome_fetta)
	else:
		print("Errore critico: Il Manager non trova il nodo chiamato: ", nome_fetta)

	# Controllo Vittoria: se arrivi a 6 hai ricomposto la parola KISMET
	if lettere_raccolte == TOTALE_LETTERE:
		vittoria_livello()

func vittoria_livello() -> void:
	print("TRIONFO FINALE: La parola KISMET è completa! Il teatro è risorto!")
	# Qui puoi far apparire la tua bandierina finale per cambiare livello, ad esempio:
	# if has_node("../Bandierina"):
	#     get_node("../Bandierina").visible = true
