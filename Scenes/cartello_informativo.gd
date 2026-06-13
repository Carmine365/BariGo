extends StaticBody2D

# Espone una casella di controllo (checkbox) nell'Ispettore.
# Se vera, il cartello verrà specchiato orizzontalmente.
@export var specchia_orizzontalmente: bool = false

# Espone un pacchetto vuoto nell'Ispettore dove puoi trascinare un file immagine (.png/.jpg)
@export var texture_personalizzata: Texture2D

# Esponiamo all'Ispettore la stringa per scegliere quale blocco di dialogo avviare.
# Di default lo impostiamo su un blocco generico.
@export var id_dialogo: String = "start"

func _ready() -> void:
	# 1. Gestione del Mirroring Dinamico
	# Accediamo alla proprietà 'flip_h' del nodo Sprite2D figlio.
	$Sprite2D.flip_h = specchia_orizzontalmente
	
	# 1. Gestione della Grafica Dinamica
	# Se nell'Ispettore hai trascinato una texture, sovrascriviamo quella di default
	if texture_personalizzata != null:
		$Sprite2D.texture = texture_personalizzata
	
	# Quando il gioco parte, il nodo radice prende la stringa che hai scritto 
	# nell'Ispettore e la passa al nodo figlio Actionable.
	# Assicurati che il nome "$Actionable" corrisponda esattamente al nome del tuo nodo figlio.
	if has_node("Actionable"):
		$Actionable.dialogue_start = id_dialogo
	else:
		printerr("Errore architetturale: Il Cartello non ha un figlio chiamato Actionable.")
