extends KinematicBody2D

var velocity = Vector2.ZERO
var mv_speed = 160
var mv_direction = Vector2(0,0)
#var mv_direction
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
var cartaAtual = "Nenhuma"
signal Attack
signal health
signal spawn_miniboss
signal next_level

func _ready():
	Socket.connect("esquerda", self, "MoverEsquerda")
	Socket.connect("direita", self, "MoverDireita")
	Socket.connect("cima", self, "MoverCima")
	Socket.connect("baixo", self, "MoverBaixo")
	Socket.connect("ataque", self, "Ataque")
	Socket.connect("ponto_morto", self, "Neutral")
	Socket.write_text("Reset\n")

func _physics_process(delta):
	if ondas >= 3:
		contadorInimigos = 0
		ondas = 0
		isCatKnightOn = true
		get_parent()._on_Bruxinha_spawn_miniboss()
		print("pode passar para o próximo estágio")
	
	if contadorInimigos >= 3 and !isCatKnightOn:
		print(ondas)
		msg_sent = true
		contadorInimigos = 0
		ondas += 1
		checaOnda()
		print("Proxima onda chegando...")
		get_parent().spawn_item()
		yield(get_tree().create_timer(5), "timeout")
		if get_parent().itemOn == true:
			get_parent().get_node("Item").despawn_item()
		get_parent().SpawnarInimigos()
	
	if canMove:
		if joystick_right or Input.is_action_pressed("direita"):
			velocity.x = 1 *mv_speed
			$SpriteBruxinha.play("Walking")
			$SpriteBruxinha.flip_h = false
		if joystick_left or Input.is_action_pressed("esquerda"):
			velocity.x = -1 * mv_speed
			$SpriteBruxinha.play("Walking")
			$SpriteBruxinha.flip_h = true
		
		if Input.is_action_just_released("direita") or Input.is_action_just_released("esquerda") or Input.is_action_just_released("cima") or Input.is_action_just_released("baixo"):
			velocity.x = 0
			velocity.y = 0
		
		if joystick_down or Input.is_action_pressed("baixo"):
			velocity.y = 1 * mv_speed
			$SpriteBruxinha.play("Walking")
		if joystick_up or Input.is_action_pressed("cima"):
			velocity.y = -1 * mv_speed
			$SpriteBruxinha.play("Walking")
	
		if Input.is_action_just_pressed("ataque"):
			$AtivacaoCarta/ColisaoAtivacao.disabled = false
			print("Apertou barra de espaço")
		else:
			$AtivacaoCarta/ColisaoAtivacao.disabled = true
	
		if velocity.x  == 0 and velocity.y == 0 and canMove == true:
			$SpriteBruxinha.play("Idle")
			
		move_and_slide(velocity, Vector2.UP)
		
	if auto_movement:
		move_and_slide(auto_direction * mv_speed *30 * delta)
		$SpriteBruxinha.play("Walking")

func MoverDireita():
	joystick_right = true
	
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
#	hp -= 1
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
#		yield(get_tree().create_timer(3), "timeout")
		

func Ataque():
	canMove = false
	$AreaAttack/ColisaoAttack.disabled = false
	if $SpriteBruxinha.flip_h == false:
		$SpriteBruxinha.offset.x = 32
		$AreaAttack/ColisaoAttack.position.x = 50
	if $SpriteBruxinha.flip_h == true:
		$SpriteBruxinha.offset.x = -32
		$AreaAttack/ColisaoAttack.position.x = -50
	$SpriteBruxinha.play("Attack")
	$Hit2.play()

func _on_SpriteBruxinha_animation_finished():
	if $SpriteBruxinha.animation == "Attack":
		$SpriteBruxinha.offset.x = 0
		$SpriteBruxinha.play("Walking")
		$AreaAttack/ColisaoAttack.disabled = true
		canMove = true
	if $SpriteBruxinha.animation == "Hit":
		canMove = true
	if $SpriteBruxinha.animation == "Dead":
		get_tree().change_scene("res://Jogo/GameOver.gd")

func _on_AreaAttack_body_entered(body):
	if body.is_in_group("Inimigo"):
		body.TomarDano()
	if body.name == "CatKnight":
		yield(get_tree().create_timer(0.3), "timeout")
		body.TomouDano()
#	if body.name == "ChickBoy":
#		body.TomarDano()
#	if body.name == "ChickBoy_2":
#		body.TomarDano()
		
func checaOnda():
	if ondas == 1 and msg_sent:
		Socket.write_text("Onda1\n")
		msg_sent = false
	if ondas == 2:
		Socket.write_text("Onda2\n")
	if ondas == 3:
		Socket.write_text("Onda3\n")
	if ondas == 4:
		Socket.write_text("Onda4\n")
		
func oneup():
	$ItemGot.play()

func _on_Intro_toggle_movement():
	canMove = false

func _on_DialogueBox_intro_dialogue_finished():
	auto_movement = true

func _on_Level1_toggle_movement():
	auto_movement = false
	canMove = true

func _on_LevelFinal_toggle_movement():
	canMove = false

func _on_DialogueBox_arena_dialogue_pt1_finished():
	canMove = true

func _on_CatKnight_dialogue_play():
	canMove = false
	yield(get_tree().create_timer(7.0), "timeout")
	canMove = true
