extends Node

@export var label_contatore: Label 
@export var vittoria_label: Label 
var oggetti_totali = 0

func _ready():
	if label_contatore:
		label_contatore.text = "Oggetti di scena raccolti: 0/4"
	if vittoria_label:
		vittoria_label.visible = false # Spenta all'inizio

func aggiungi_punto():
	oggetti_totali += 1
	if label_contatore:
		label_contatore.text = "Oggetti di scena raccolti: " + str(oggetti_totali) + "/4"

func attiva_vittoria():
	if vittoria_label:
		vittoria_label.visible = true
