extends Control

# FORSE DA ELIMINARE
@onready var label_monete = $VBoxContainer/CoinCounter
@onready var barra_xp = $VBoxContainer/BarraXP 

func _process(_delta):
	# Ora che le hai aggiunte in global.gd, queste righe funzioneranno!
	label_monete.text = "Moneteee: " + str(global.coin)
	barra_xp.value = global.xp
