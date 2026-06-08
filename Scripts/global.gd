extends Node

var player: Node = null
var coin: int = 0
var xp: int = 0

var storie_raccontate: int = 0 # Contatore per sapere quale pillola didattica sbloccare
var diario_storico: String = "[center][b]--- APPUNTI SUI TEATRI DI BARI ---[/b][/center]\n\n"

func aggiungi_appunto(teatro: String, descrizione: String) -> void:
	# Qui \n funziona perfettamente perché siamo in GDScript puro
	diario_storico += "[b]" + teatro + ":[/b] " + descrizione + "\n\n"
	
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
