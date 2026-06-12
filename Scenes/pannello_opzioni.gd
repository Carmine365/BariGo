extends VBoxContainer

signal chiedo_di_chiudere

func _ready() -> void:
	var btn_indietro = find_child("BtnIndietro", true, false)
	if btn_indietro:
		btn_indietro.pressed.connect(_on_indietro_premuti)
	else:
		print("ERRORE: Non trovo il tasto 'BtnIndietro' nel Pannello Opzioni!")

func _on_indietro_premuti() -> void:
	chiedo_di_chiudere.emit()
