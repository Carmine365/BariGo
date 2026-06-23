extends Node

# --- Variabili di stato gioco ---
var exp_attuale: int = 0
var exp_max: int = 6
var monete: int = 0

# --- Nuova variabile per gestire l'intro ---
var intro_vista: bool = false

signal exp_aggiornata(valore_percentuale)

func guadagna_esperienza():
	exp_attuale += 1
	print("Esperienza attuale: ", exp_attuale)
	# Calcoliamo la percentuale (33%, 66%, 100%)
	var percentuale = (float(exp_attuale) / exp_max) * 100
	exp_aggiornata.emit(percentuale)
	
	if exp_attuale >= exp_max:
		monete += 2
		exp_attuale = 0
		print("Bonus monete! Totale: ", monete)
		exp_aggiornata.emit(0) # Resetta la barra visiva
