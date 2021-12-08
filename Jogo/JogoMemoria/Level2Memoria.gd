extends Node2D

var dialogue_played = false
var dialogue_played_victory = false
var cartaVirada = false
var primeiraCartaPos = Vector2(212, 312)
var arrayPos1 = [primeiraCartaPos, primeiraCartaPos+Vector2(64+13, 00), primeiraCartaPos+Vector2(128+26, 00)]
var arrayPos2 = [primeiraCartaPos+Vector2(00, 89+13), primeiraCartaPos+Vector2(64+13, 89+13), primeiraCartaPos+Vector2(128+26, 89+13)]
var arrayPos3 = [primeiraCartaPos+Vector2(00, 178+26), primeiraCartaPos+Vector2(64+13, 178+26), primeiraCartaPos+Vector2(128+26, 178+26)]
var arrayPos4 = [primeiraCartaPos+Vector2(00, 267+39), primeiraCartaPos+Vector2(64+13, 267+39), primeiraCartaPos+Vector2(128+26, 267+39)]
var tabuleiroPos = [arrayPos1, arrayPos2,arrayPos3, arrayPos4
#	[primeiraCartaPos, primeiraCartaPos+Vector2(64+13, 00), primeiraCartaPos+Vector2(128+26, 00)],
#	[primeiraCartaPos+Vector2(00, 89+13), primeiraCartaPos+Vector2(64+13, 89+13), primeiraCartaPos+Vector2(128+26, 89+13)],
#	[primeiraCartaPos+Vector2(00, 178+26), primeiraCartaPos+Vector2(64+13, 178+26), primeiraCartaPos+Vector2(128+26, 178+26)],
#	[primeiraCartaPos+Vector2(00, 267+39), primeiraCartaPos+Vector2(64+13, 267+39), primeiraCartaPos+Vector2(128+26, 267+39)],
	]
var cartasAnimacoes = ["Bruxa",
				"Slime",
				"Pumpkin",
				"CatKnight",
				"Chicken",
				"Frog",
				"Bruxa",
				"Slime",
				"Pumpkin",
				"CatKnight",
				"Chicken",
				"Frog"]
var carta

func _ready():

	$Bruxinha.teleport_backwards()
	$Bruxinha.level = 2
	
	randomize()
	carta = load("res://Jogo/JogoMemoria/Carta.tscn")
	randomize()
	criarTabuleiro()
	GlobalJogoMemoria.quantidadeCartasDescobertas = 0
	GlobalJogoMemoria.passarFase = false
	GlobalJogoMemoria.lvl1 = false
	GlobalJogoMemoria.lvl2 = true
	GlobalJogoMemoria.lvl3 = false
	$Timer/Timer.minutos = 0
	$Timer/Timer.segundos = 0

func _process(delta):
	if GlobalJogoMemoria.quantidadeCartasDescobertas > 11  and !dialogue_played_victory:
		if !GlobalJogoMemoria.speedRunMode:
			$DialogueBox.level2_victory()
		GlobalJogoMemoria.passarFase = true
		dialogue_played_victory = true
		GlobalJogoMemoria.passarFase = true

func criarTabuleiro():	
	var arrayCartas = [0,1,2,3,4,5,6,7,8,9,10,11]
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
	tabuleiroPos.shuffle()
	
	for i in range(tabuleiroPos.size()):
		for j in range(tabuleiroPos[i].size()):
			arrayCartas[indiceCartas].position = tabuleiroPos[i][j]
			$Cartas.add_child(arrayCartas[indiceCartas])
			indiceCartas += 1

func _on_Progressao_body_entered(body):
	if body.name == "Bruxinha":
		if GlobalJogoMemoria.quantidadeCartasDescobertas > 11:
			$Bruxinha.canMove = false
			$Bruxinha.teleport()
			
		else:
			print("Não pode passar ainda")
