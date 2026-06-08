extends Node

signal appunto_aggiunto

# Riferimenti ai player audio
var _player_moneta: AudioStreamPlayer
var _player_successo: AudioStreamPlayer
var _player_fallimento: AudioStreamPlayer

var player: Node = null
var coin: int = 0
var xp: int = 0

var storie_raccontate: int = 0 # Contatore per sapere quale pillola didattica sbloccare
var diario_storico: String = "[center][b]--- APPUNTI SUI TEATRI DI BARI ---[/b][/center]\n\n"

func _ready() -> void:
	# Istanziamo i nodi audio direttamente in RAM
	_player_moneta = AudioStreamPlayer.new()
	_player_successo = AudioStreamPlayer.new()
	_player_fallimento = AudioStreamPlayer.new()
	
	# Li aggiungiamo all'albero di gioco sotto il Singleton
	add_child(_player_moneta)
	add_child(_player_successo)
	add_child(_player_fallimento)
	
	# Configura qui i percorsi esatti dei tuoi file .wav scaricati
	_player_moneta.stream = load("res://assets (2)/audio/coin_pickup.ogg")
	_player_successo.stream = load("res://assets (2)/audio/transaction_success.ogg")
	_player_fallimento.stream = load("res://assets (2)/audio/error_buzz.ogg")

	#_player_successo.volume_db = 
	_player_fallimento.volume_db = -20
	_player_moneta.volume_db = -10

# Funzioni pubbliche per attivare i suoni da qualsiasi punto del gioco
func play_suono_moneta() -> void:
	print("maonte")
	_player_moneta.play()

func play_suono_successo() -> void:
	_player_successo.play()

func play_suono_fallimento() -> void:
	_player_fallimento.play()

func aggiungi_appunto(teatro: String, descrizione: String) -> void:
	# Qui \n funziona perfettamente perché siamo in GDScript puro
	diario_storico += "[b]" + teatro + ":[/b] " + descrizione + "\n\n"
	# Emettiamo il segnale per avvisare chiunque stia ascoltando
	appunto_aggiunto.emit()
	
# La variabile magica: conterrà il percorso del minigioco da avviare
var next_minigame_scene: String = ""

# Un dizionario generico per tracciare lo stato di TUTTE le quest del gioco
# Evita di creare 50 variabili booleane
var quest_states: Dictionary = {
	"petruzzelli": "not_started", # Può essere: "not_started", "started", "completed"
	"margherita": "not_started",
	"kismet": "not_started",
	"forma": "not_started", # Può essere: "not_started", "started", "completed"
	"piccinni": "not_started",
	"team": "not_started"
}

# --- VARIABILI DI SPAWN ---
var map_return_position: Vector2 = Vector2.ZERO
var has_saved_position: bool = false
# --------------------------
