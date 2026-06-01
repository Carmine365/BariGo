extends Node

# Aggiungi questa variabile per puntare alla Label
@export var label_contatore: Label 
@export var vittoria_label: Label

var oggetti_totali = 0

func aggiungi_punto():
	oggetti_totali += 1
	
	if label_contatore:
		label_contatore.text = "Oggetti di scena raccolti: " + str(oggetti_totali) + "/4"
	
	print("Oggetti di scena raccolti: ", oggetti_totali, "/4")
	
func mostra_vittoria():
	print("Vittoria attivata nel GameManager!") # Mettiamoci un print per vedere se arriva qui
	if vittoria_label:
		vittoria_label.visible = true
		
		
func _ready():
	if label_contatore:
		label_contatore.text = "Oggetti di scena raccolti: 0/4"
