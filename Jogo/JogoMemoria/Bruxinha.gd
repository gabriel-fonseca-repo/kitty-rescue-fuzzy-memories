extends KinematicBody2D

var velocity = Vector2.ZERO
var mv_speed = 160
var mv_direction = Vector2(0,0)
var canMove = true
var auto_direction = Vector2.UP
var auto_movement = false
var hp = Global.health
var contadorInimigos = 0
var ondas = 0
var msg_sent = false
var gatos = 0
var proxEstagio = false
var Level1 = get_parent()
var joystick_right = false
var joystick_left = false
var joystick_up = false
var joystick_down = false
var isCatKnightOn = false
var canAttack = true
var level = 0 #memoria
var attack = false
signal Attack
signal health
signal spawn_miniboss
signal next_level
signal level_transition #memoria
const dialoguescene = preload("res://Jogo/DialogueBox.tscn") #Memoria



func _ready():
	Socket.connect("esquerda", self, "MoverEsquerda")
	Socket.connect("direita", self, "MoverDireita")
	Socket.connect("cima", self, "MoverCima")
	Socket.connect("baixo", self, "MoverBaixo")
	Socket.connect("ataque", self, "Ataque")
	Socket.connect("ponto_morto", self, "Neutral")
	Socket.connect("naoAtaque", self, "naoAtaque")
	Socket.write_text("Reset\n")

func _physics_process(delta):
	
#	print(GlobalJogoMemoria.qtdCartasViradas)
	
	if canMove:
		if joystick_right or Input.is_action_pressed("direita"):
			velocity.x = 1 *mv_speed
			if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
				velocity.x = 1 * mv_speed * (1-GlobalJogoMemoria.value)
			$SpriteBruxinha.play("Walking")
			$SpriteBruxinha.flip_h = false
		if joystick_left or Input.is_action_pressed("esquerda"):
			velocity.x = -1 * mv_speed
			if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
				velocity.x = -1 * mv_speed * (1-GlobalJogoMemoria.value)
			$SpriteBruxinha.play("Walking")
			$SpriteBruxinha.flip_h = true
		
		if Input.is_action_just_released("direita") or Input.is_action_just_released("esquerda") or Input.is_action_just_released("cima") or Input.is_action_just_released("baixo"):
			velocity.x = 0
			velocity.y = 0
		
		if Input.is_action_just_pressed("ataque") or attack:
			$AtivacaoCarta/ColisaoAtivacao.disabled = false
			print("Apertou barra de espaço")
		elif !attack:
			$AtivacaoCarta/ColisaoAtivacao.disabled = true
		
		if joystick_down or Input.is_action_pressed("baixo"):
			velocity.y = 1 * mv_speed
			if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
				velocity.y = 1 * mv_speed * (1-GlobalJogoMemoria.value)
			$SpriteBruxinha.play("Walking")
		if joystick_up or Input.is_action_pressed("cima"):
			velocity.y = -1 * mv_speed
			if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
				velocity.y = -1 * mv_speed * (1-GlobalJogoMemoria.value)
			$SpriteBruxinha.play("Walking")
		if velocity.x  == 0 and velocity.y == 0 and canMove == true:
			$SpriteBruxinha.play("Idle")
			
		move_and_slide(velocity, Vector2.UP)
		
	if auto_movement:
		move_and_slide(auto_direction * mv_speed *30 * delta)
		$SpriteBruxinha.play("Walking")

func MoverDireita():
	joystick_right = true

func Ataque():
	attack = true
#	$AtivacaoCarta/ColisaoAtivacao.disabled = false
func naoAtaque():
#	$AtivacaoCarta/ColisaoAtivacao.disabled = true
	attack = false
	
func Neutral():
	joystick_right = false
	joystick_left = false
	joystick_up = false
	joystick_down = false
	velocity.x = 0
	velocity.y = 0

func MoverEsquerda():
	joystick_left = true

func MoverCima():
	joystick_up = true

func MoverBaixo():
	joystick_down = true

func LevouDano():
	Global.health -= 1
	canMove = false
	print("bruxa levou dano")
	$SpriteBruxinha.play("Hit")
	$Hurt.play()
	$SpriteBruxinha.offset.x = 0
	emit_signal("health")
	if Global.health <= 0:
		Global.health = 0
		get_node("AreaBruxinha2D/ColisaoBruxinha2D").set_deferred("disabled", true)
		get_node("ColisaoBruxinha").set_deferred("disabled", true)
		$SpriteBruxinha.play("Dead")
		$Dead.play()

func _on_SpriteBruxinha_animation_finished():
	if $SpriteBruxinha.animation == "Attack":
		$SpriteBruxinha.offset.x = 0
		$SpriteBruxinha.play("Walking")
		$AreaAttack/ColisaoAttack.disabled = true
		canMove = true
	if $SpriteBruxinha.animation == "Hit":
		canMove = true
	if $SpriteBruxinha.animation == "Dead":
		get_tree().change_scene("res://Jogo/GameOver.tscn")
	if $SpriteBruxinha.animation == "Teleport":
		if level == 0:
			get_tree().change_scene("res://Jogo/JogoMemoria/Level1Memoria.tscn")
		if level == 1:
			get_tree().change_scene("res://Jogo/JogoMemoria/Level2Memoria.tscn")
		if level == 2:
			get_tree().change_scene("res://Jogo/JogoMemoria/Level3Memoria.tscn")
	if $SpriteBruxinha.animation == "TeleportBackwards":
		if !GlobalJogoMemoria.speedRunMode:
			get_node("../ChickBoyMemoria/CameraChickBoy").current = true
			if level == 1:
				get_node("../DialogueBox").level1_intro()
			if level == 2:
				get_node("../DialogueBox").level2_mechanics_explained()
			if level == 3:
				get_node("../DialogueBox").level3_mechanics_explained()
		if GlobalJogoMemoria.speedRunMode:
			canMove = true
			if level == 2:
				GlobalJogoMemoria.comecarTimer = true
			if level == 3:
				GlobalJogoMemoria.comecarTimer = true
		
		

#func _on_AreaAttack_body_entered(body):
#	if body.is_in_group("Inimigo"):
#		body.TomarDano()
#	if body.name == "CatKnight":
#		yield(get_tree().create_timer(0.3), "timeout")
#		body.TomouDano()

func oneup():
	$ItemGot.play()
	
func teleport(): #MEMORIA
	$SpriteBruxinha.play("Teleport")
	$WarpOut.play()
	
func teleport_backwards(): #MEMORIA
	
	canMove = false
	$SpriteBruxinha.play("TeleportBackwards")
	$WarpIn.play()

func intro_movement(): #MEMORIA
	canMove = false
	

func _on_DialogueBox_intro_dialogue_finished(): #MEMORIA
	auto_movement = true

#func create_dialogue_box():
#	var current_scene = dialoguescene.instance()
#	get_tree().get_root().get_node("LevelTeste/Bruxinha/DialogueBoxPosition").add_child(current_scene)
#	get_tree().set_current_scene(current_scene)
#	print(get_tree().get_root().get_node("LevelTeste/Bruxinha/DialogueBoxPosition/DialogueBox").is_visible())
	

#func arriving(): #MEMORIA
#	canMove = false
#	$SpriteBruxinha.play("Teleport", true)
##	yield(get_tree().create_timer(0.5), "timeout")
	
	

func _on_DialogueBox_level1_dialogue_finished():
	canMove = true
	$CameraBruxinha.current = true
	


func _on_DialogueBox_level1_mechanics_explained(): #MEMORIA
	canMove = true # Replace with function body.
	$CameraBruxinha.current = true
##	GlobalJogoMemoria.comecarTimer = true
#	get_parent().criarTabuleiro()


func _on_DialogueBox_level2_mechanics_explained(): #MEMORIA
	canMove = true # Replace with function body.
	$CameraBruxinha.current = true
	GlobalJogoMemoria.comecarTimer = true


func _on_DialogueBox_level3_mechanics_explained(): #MEMORIA
	canMove = true # Replace with function body.
	$CameraBruxinha.current = true
	GlobalJogoMemoria.comecarTimer = true
