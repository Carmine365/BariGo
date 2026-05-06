extends Control

const GAME_SCENE_PATH = "res://Scenes/Game.tscn"
const SETTINGS_SCENE_PATH = "res://Scenes/MainMenu.tscn"

# I percorsi ($...) DEVONO corrispondere esattamente ai nomi dei tuoi nodi.
# Se hai chiamato un nodo "bottone1" invece di "StartButton", il gioco andrà in crash.
@onready var start_button: Button = $MarginContainer/VBoxContainer/ButtonContainer/StartButton
@onready var settings_button: Button = $MarginContainer/VBoxContainer/ButtonContainer/SettingsButton
@onready var exit_button: Button = $MarginContainer/VBoxContainer/ButtonContainer/ExitButton

func _ready() -> void:
	# 1. Verifiche di integrità. Se hai sbagliato a rinominare i nodi nell'albero,
	# l'assert blocca il gioco istantaneamente in debug e ti avvisa. 
	# Meglio un crash controllato subito che un bug silenzioso dopo.
	assert(start_button != null, "Architettura: StartButton non trovato all'avvio.")
	assert(settings_button != null, "Architettura: SettingsButton non trovato all'avvio.")
	assert(exit_button != null, "Architettura: ExitButton non trovato all'avvio.")
	
	# 2. Collegamento dei segnali via codice. 
	# Stiamo dicendo: "Quando il pulsante emette 'pressed', esegui la mia funzione".
	start_button.pressed.connect(_on_start_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	exit_button.pressed.connect(_on_exit_pressed)
	
	# 3. Focus iniziale per navigazione da tastiera/gamepad.
	start_button.grab_focus()

# --- DEFINIZIONE DELLE FUNZIONI RICEVENTI ---

func _on_start_pressed() -> void:
	if ResourceLoader.exists(GAME_SCENE_PATH):
		get_tree().change_scene_to_file(GAME_SCENE_PATH)
	else:
		push_error("Errore critico: File Game.tscn mancante in " + GAME_SCENE_PATH)

func _on_settings_pressed() -> void:
	if ResourceLoader.exists(SETTINGS_SCENE_PATH):
		get_tree().change_scene_to_file(SETTINGS_SCENE_PATH)
	else:
		push_error("Errore critico: File Settings.tscn mancante in " + SETTINGS_SCENE_PATH)

func _on_exit_pressed() -> void:
	get_tree().quit()
