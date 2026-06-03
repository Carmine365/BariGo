extends Area2D

var note_colpite = 0

@export var messaggio_vittoria: CanvasLayer 

# Usiamo una funzione per trovare i nodi, così siamo sicuri che esistano
@onready var strumenti = {
	2: "../Batteria",
	4: "../Piano",
	6: "../Chitarra",
	8: "../Microfono"
}

func _input(event):
	if event.is_action_pressed("ui_accept"):
		var corpi = get_overlapping_areas()
		for area in corpi:
			if area.is_in_group("note"):
				note_colpite += 1
				area.queue_free()
				controlla_strumenti()
				return

func controlla_strumenti():
	# Verifichiamo se il numero attuale di note ha uno strumento associato
	if strumenti.has(note_colpite):
		var path = strumenti[note_colpite]
		var strumento = get_node_or_null(path)
		
		if strumento:
			strumento.visible = true
			strumento.modulate.a = 0 
			
			var tween = create_tween()
			tween.tween_property(strumento, "modulate:a", 1.0, 1.0)
			
			print("Strumento apparso: ", strumento.name)
			
			# Se è l'ottava nota, il finale attende l'animazione
			if note_colpite == 8:
				await tween.finished
				mostra_vittoria()

func mostra_vittoria():
	# Forza la visibilità del CanvasLayer e della sua Label interna
	if messaggio_vittoria:
		messaggio_vittoria.visible = true
		var label = messaggio_vittoria.get_node_or_null("TestoVittoria")
		if label:
			label.visible = true
		
	# Congela il gioco
	get_tree().paused = true
	
	# Aspetta 3 secondi, poi ripristina e cambia scena
	await get_tree().create_timer(3.0, true, false, true).timeout
	
	# Aggiorniamo lo stato della missione nel Singleton
	global.quest_states["team"] = "completed"
	var scene_to_load: String = global.next_minigame_scene
		
	# Puliamo immediatamente il Singleton per i dialoghi futuri
	global.next_minigame_scene = ""	
		
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
