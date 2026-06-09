extends Node

# Variabili di stato
var exp_attuale = 0
var exp_max = 3
var monete = global.coin

# Riferimento alla barra (che collegheremo subito)
@export var barra_xp: TextureProgressBar

func guadagna_esperienza():
	exp_attuale += 1
	aggiorna_barra()
	
	if exp_attuale >= exp_max:
		monete += 2
		exp_attuale = 0
		print("Bonus monete! Totale: ", monete)
		# Qui potresti aggiungere un suono o un effetto particellare!
		aggiorna_barra()

func aggiorna_barra():
	if barra_xp:
		# Calcola la percentuale: 1/3 = 33%, 2/3 = 66%, 3/3 = 100%
		barra_xp.value = (float(exp_attuale) / exp_max) * 100
