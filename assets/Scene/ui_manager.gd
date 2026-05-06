extends Control

# Nota il percorso: dobbiamo entrare nel VBoxContainer!
@onready var label_monete = $VBoxContainer/CoinCounter
@onready var barra_xp = $VBoxContainer/BarraXP 

func _process(_delta):
	# Ora che le hai aggiunte in global.gd, queste righe funzioneranno!
	label_monete.text = "Focacce: " + str(global.coin)
	barra_xp.value = global.xp
