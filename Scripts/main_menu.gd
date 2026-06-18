extends Control

@onready var pannello_opzioni = $PannelloOpzioni
@onready var main_menu_ui = $MarginContainer
@onready var slider_musica = $PannelloOpzioni/SliderMusica
@onready var slider_effetti = $PannelloOpzioni/SliderEffetti
@onready var label_musica = $PannelloOpzioni/labelMusica
@onready var label_effetti = $PannelloOpzioni/LabelEffetti

func _ready():
	# Nascondi pannello opzioni all'avvio
	pannello_opzioni.visible = false
	main_menu_ui.visible = true
	
	# Collega i pulsanti
	$MarginContainer/VBoxContainer/ButtonContainer/StartButton.pressed.connect(_on_start_pressed)
	$MarginContainer/VBoxContainer/ButtonContainer/SettingsButton.pressed.connect(_on_settings_pressed)
	$MarginContainer/VBoxContainer/ButtonContainer/ExitButton.pressed.connect(_on_exit_pressed)
	$PannelloOpzioni/ExitButton.pressed.connect(_on_options_exit_pressed)
	
	# Collega gli slider
	slider_musica.value_changed.connect(_on_music_slider_changed)
	slider_effetti.value_changed.connect(_on_sfx_slider_changed)
	
	# Configura gli slider
	slider_musica.min_value = 0.0
	slider_musica.max_value = 1.0
	slider_musica.step = 0.01
	
	slider_effetti.min_value = 0.0
	slider_effetti.max_value = 1.0
	slider_effetti.step = 0.01
	
	# Carica i valori correnti
	load_slider_values()

func load_slider_values():
	var audio_manager = get_node("/root/AudioManager")
	slider_musica.value = audio_manager.get_music_volume_linear()
	slider_effetti.value = audio_manager.get_sfx_volume_linear()
	update_volume_labels()

func update_volume_labels():
	label_musica.text = "Musica: " + str(int(slider_musica.value * 100)) + "%"
	label_effetti.text = "Effetti: " + str(int(slider_effetti.value * 100)) + "%"

func _on_start_pressed():
	print("Avvio gioco...")
	# Sostituisci con la tua scena di gioco
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_settings_pressed():
	main_menu_ui.visible = false
	pannello_opzioni.visible = true

func _on_options_exit_pressed():
	main_menu_ui.visible = true
	pannello_opzioni.visible = false

func _on_exit_pressed():
	get_tree().quit()

func _on_music_slider_changed(value: float):
	var audio_manager = get_node("/root/AudioManager")
	audio_manager.set_music_volume_linear(value)
	update_volume_labels()

func _on_sfx_slider_changed(value: float):
	var audio_manager = get_node("/root/AudioManager")
	audio_manager.set_sfx_volume_linear(value)
	update_volume_labels()

func _on_credit_button_pressed():
	# Carica e istanzia la scena dei crediti, distruggendo il menu principale
	# ATTENZIONE: Devi inserire il percorso esatto in cui hai salvato la scena!
		get_tree().change_scene_to_file("res://Scenes/MenuCrediti.tscn")
