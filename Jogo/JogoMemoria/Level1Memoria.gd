extends Node2D

var dialogue_played = false
var dialogue_played_victory = false
var cartaVirada = false
var primeiraCartaPos = Vector2(-101, -365)
var arrayPos1 = [primeiraCartaPos, primeiraCartaPos+Vector2(64+13, 00), primeiraCartaPos+Vector2(128+26, 00)]
var arrayPos2 = [primeiraCartaPos+Vector2(00, 89+13), primeiraCartaPos+Vector2(64+13, 89+13), primeiraCartaPos+Vector2(128+26, 89+13)]
var tabuleiroPos = [arrayPos1, arrayPos2]
	
var cartasAnimacoes = ["Slime",
				"Chicken",
				"Frog",
				"Slime",
				"Chicken",
				"Frog"]
var carta

func _ready():
	GlobalJogoMemoria.comecarTimer = false
	$Bruxinha.teleport_backwards()
	$Bruxinha.level = 1
	
 #espera a animação acabar
	
##	$Bruxinha/Camera2D.current = false
#
#	$ChickBoyMemoria/CameraChickBoy.current = true #corta pra cÂmera do chickboy
#	print($Bruxinha/CameraBruxinha.is_current()) #checar se a camera da bruxinha é a atual
#	$DialogueBox.level1_start() #diálogo chickboy

	randomize()
	carta = load("res://Jogo/JogoMemoria/Carta.tscn")
	randomize()
	criarTabuleiro()
	GlobalJogoMemoria.quantidadeCartasDescobertas = 0
	GlobalJogoMemoria.passarFase = false
	GlobalJogoMemoria.lvl1 = true
	GlobalJogoMemoria.lvl2 = false
	GlobalJogoMemoria.lvl3 = false
	
#func game_start():
#	$Timer/Timer.minutos = 5 #timer não começa automaticamente, só quando o chickboy explicar as mecânicas

func _process(delta):
	if GlobalJogoMemoria.quantidadeCartasDescobertas > 5 and !dialogue_played_victory:
		if !GlobalJogoMemoria.speedRunMode:
			$DialogueBox3.level1_victory()
		GlobalJogoMemoria.passarFase = true
		dialogue_played_victory = true

func criarTabuleiro():
	var arrayCartas = [0,1,2,3,4,5]
	var indiceCartas = 0
	
	for i in range(arrayCartas.size()):
		arrayCartas[i] = carta.instance()
		arrayCartas[i].cartaAnimacao = cartasAnimacoes[i]
		arrayCartas[i].nomeCarta = cartasAnimacoes[i]
	
	cartasAnimacoes.shuffle()
	cartasAnimacoes.shuffle()
	arrayPos1.shuffle()
	arrayPos2.shuffle()
	tabuleiroPos.shuffle()
	
	for i in range(tabuleiroPos.size()):
		for j in range(tabuleiroPos[i].size()):
			arrayCartas[indiceCartas].position = tabuleiroPos[i][j]
			$Cartas.add_child(arrayCartas[indiceCartas])
			indiceCartas += 1

func _on_Progressao_body_entered(body):
	if body.name == "Bruxinha":
		if GlobalJogoMemoria.passarFase == true:
			print("pode passar pro nível 2")
		if GlobalJogoMemoria.quantidadeCartasDescobertas > 5:
			$Bruxinha.canMove = false
			$Bruxinha.teleport()
			GlobalJogoMemoria.passarFase = false
			
		else:
			print("Não pode passar ainda")

#
func _on_GameStart_body_entered(body):
	if body.name == "Bruxinha" and !dialogue_played and !GlobalJogoMemoria.speedRunMode:
		body.canMove = false
		$DialogueBox.level1_mechanics_explained()
		dialogue_played = true
		
func change_camera_toChickBoy():
	$ChickBoyMemoria/CameraChickBoy.current = true
	
func change_camera_toKitty():
	$Bruxinha/CameraBruxinha.current = true



func _on_DialogueBox2_level1_Kitty_finished():
		$ChickBoyMemoria/CameraChickBoy.current = true
#		$DialogueBox.level1_mechanics_explained() # Replace with function body.
