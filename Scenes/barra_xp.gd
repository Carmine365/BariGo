extends TextureProgressBar

func _process(_delta):
	var percentuale = (float(GameManager.exp_attuale) / GameManager.exp_max) * 100
	value = percentuale

func _on_exp_cambiata(nuovo_valore):
	print("La barra sta ricevendo: ", nuovo_valore)
	value = nuovo_valore
