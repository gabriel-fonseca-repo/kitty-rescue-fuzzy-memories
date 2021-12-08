extends Node2D

var cartaVirada = false
var tabuleiroPos = [
	[Vector2(00, 00), Vector2(64, 00), Vector2(128, 00), Vector2(192, 00)],
	[Vector2(00, 89), Vector2(64, 89), Vector2(128, 89), Vector2(192, 89)],
	[Vector2(00, 178), Vector2(64, 178), Vector2(128, 178), Vector2(192, 178)],
	[Vector2(00, 267), Vector2(64, 267), Vector2(128, 267), Vector2(192, 267)],
	[Vector2(00, 356), Vector2(64, 356), Vector2(128, 356), Vector2(192, 356)]]
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

func _ready():
	randomize()
	carta = load("res://Jogo/JogoMemoria/Carta.tscn")
	randomize()
	criarTabuleiro()

func criarTabuleiro():
	
	var arrayCartas = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19]
	var indiceCartas = 0
	
	for i in range(arrayCartas.size()):
		arrayCartas[i] = carta.instance()
		arrayCartas[i].cartaAnimacao = cartasAnimacoes[i]
		arrayCartas[i].nomeCarta = cartasAnimacoes[i]
	
	cartasAnimacoes.shuffle()
	cartasAnimacoes.shuffle()
	
	for i in range(tabuleiroPos.size()):
		for j in range(tabuleiroPos[i].size()):
			arrayCartas[indiceCartas].position = tabuleiroPos[i][j]
			$Cartas.add_child(arrayCartas[indiceCartas])
			indiceCartas += 1
		
	
