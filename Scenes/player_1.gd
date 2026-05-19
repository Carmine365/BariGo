extends CharacterBody2D

const VELOCITA = 200.0
var fusibili_presi = 0

@onready var sprite = $AnimatedSprite2D 
@onready var luce = $PointLight2D

func _physics_process(_delta):
	var direzione = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direzione:
		velocity = direzione * VELOCITA
	else:
		velocity.x = move_toward(velocity.x, 0, VELOCITA)
		velocity.y = move_toward(velocity.y, 0, VELOCITA)

	move_and_slide()
	
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			if velocity.x > 0:
				sprite.play("corsaDX")
			else:
				sprite.play("corsaSX")
		else:
			if velocity.y > 0:
				sprite.play("corsa giù")
			else:
				sprite.play("corsa SU")
	else:
		sprite.play("idle")

func aumenta_raggio_luce():
	# Controllo di sicurezza: se la luce non esiste, non provare a cambiarla
	if not luce:
		print("ERRORE: Luce non trovata!")
		return
		
	fusibili_presi += 1 
	print("Fusibili raccolti: ", fusibili_presi)
	
	if fusibili_presi == 1:
		luce.texture_scale = 4.0
	elif fusibili_presi == 2:
		luce.texture_scale = 7.0
	elif fusibili_presi >= 3:
		luce.texture_scale = 60.0
	
	# Forza l'aggiornamento grafico
	luce.queue_redraw()
