extends Node2D

var dialogue_played = false
var dialogue_played_victory = false

var cartaVirada = false
var primeiraCartaPos = Vector2(363, 78)
var arrayPos1 = [primeiraCartaPos, primeiraCartaPos+Vector2(64+13, 00), primeiraCartaPos+Vector2(128+26, 00), primeiraCartaPos+Vector2(192+39, 00)]
var arrayPos2 = [primeiraCartaPos+Vector2(00, 89+13), primeiraCartaPos+Vector2(64+13, 89+13), primeiraCartaPos+Vector2(128+26, 89+13), primeiraCartaPos+Vector2(192+39, 89+13)]
var arrayPos3 = [primeiraCartaPos+Vector2(00, 178+26), primeiraCartaPos+Vector2(64+13, 178+26), primeiraCartaPos+Vector2(128+26, 178+26), primeiraCartaPos+Vector2(192+39, 178+26)]
var arrayPos4 = [primeiraCartaPos+Vector2(00, 267+39), primeiraCartaPos+Vector2(64+13, 267+39), primeiraCartaPos+Vector2(128+26, 267+39), primeiraCartaPos+Vector2(192+39, 267+39)]
var arrayPos5 = [primeiraCartaPos+Vector2(00, 356+52), primeiraCartaPos+Vector2(64+13, 356+52), primeiraCartaPos+Vector2(128+26, 356+52), primeiraCartaPos+Vector2(192+39, 356+52)]
var tabuleiroPos = [arrayPos1, arrayPos2, arrayPos3, arrayPos4, arrayPos5]
var cartasAnimacoes = ["Bruxa",
				"Slime",
				"Pumpkin",
				"CatKnight",
				"ChickBoy",
				"Chicken",
				"Frog",
				"Skeleton",
				"Cat",
				"CatNoBanana",
				"Bruxa",
				"Slime",
				"Pumpkin",
				"CatKnight",
				"ChickBoy",
				"Chicken",
				"Frog",
				"Skeleton",
				"Cat",
				"CatNoBanana"]
var carta
var qtdCartasSet = false

func _ready():
	$CameraLevel3.current = false
	$Bruxinha/CameraBruxinha.current = true
	$Cat.visible = false
	$Cat2.visible = false
	$Cat3.visible = false
	
	$Bruxinha.teleport_backwards()
	if GlobalJogoMemoria.speedRunMode:
		$CameraLevel3.current = true
	$Bruxinha.level = 3
	
	randomize()
	carta = load("res://Jogo/JogoMemoria/Carta.tscn")
	randomize()
	criarTabuleiro()
	GlobalJogoMemoria.quantidadeCartasDescobertas = 0
	qtdCartasSet = true
	GlobalJogoMemoria.passarFase = false
	GlobalJogoMemoria.lvl1 = false
	GlobalJogoMemoria.lvl2 = false
	GlobalJogoMemoria.lvl3 = true
	$Timer/Timer.minutos = 0
	$Timer/Timer.segundos = 0

func _process(delta):
	if qtdCartasSet:
		if GlobalJogoMemoria.quantidadeCartasDescobertas > 19 and !dialogue_played_victory:
			Socket.write_text("Vibra0\n")
			$Bruxinha.position.x = 470
			$Bruxinha.position.y = 350
			$ChickBoyMemoria.position.x = 640
			$ChickBoyMemoria.position.y = 350
			$Cat.visible = true
			$Cat2.visible = true
			$Cat3.visible = true
			$CameraFinal.current = true
			if !GlobalJogoMemoria.speedRunMode:
				$DialogueBox2.level3_victory()
#			if GlobalJogoMemoria.speedRunMode:
#				colocar tela com o tempo q o jogador conseugiu aqui
			GlobalJogoMemoria.passarFase = true
			dialogue_played_victory = true
			

func criarTabuleiro():
	
	var arrayCartas = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	var indiceCartas = 0
	
	for i in range(arrayCartas.size()):
		arrayCartas[i] = carta.instance()
		arrayCartas[i].cartaAnimacao = cartasAnimacoes[i]
		arrayCartas[i].nomeCarta = cartasAnimacoes[i]
	
	cartasAnimacoes.shuffle()
	cartasAnimacoes.shuffle()
	arrayPos1.shuffle()
	arrayPos2.shuffle()
	arrayPos3.shuffle()
	arrayPos4.shuffle()
	arrayPos5.shuffle()
	tabuleiroPos.shuffle()
	
	for i in range(tabuleiroPos.size()):
		for j in range(tabuleiroPos[i].size()):
			arrayCartas[indiceCartas].position = tabuleiroPos[i][j]
			$Cartas.add_child(arrayCartas[indiceCartas])
			indiceCartas += 1

func _on_Progressao_body_entered(body):
	if body.name == "Bruxinha":
		if GlobalJogoMemoria.quantidadeCartasDescobertas > 19:
			$Bruxinha.intro_movement()
			$ChickBoyMemoria/CameraChickBoy.current = true
			get_tree().quit()
		else:
			print("Não pode passar ainda")
