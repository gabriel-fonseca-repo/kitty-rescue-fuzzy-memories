extends Node2D

func _ready():
	yield(get_parent(), "ready")
	for children in get_children():
#		print(children)
		children.connect("DeletarCarta", self, "DeletarCarta")
		children.connect("VirarCarta", self, "VirarCarta")

func DeletarCarta(cartaNome):
	print("deletou carta")
	for children in get_children():
		if children.nomeCarta == cartaNome:
			children.get_node("Animacoes").play("DesaparecerCarta" + children.cartaAnimacao)
			GlobalJogoMemoria.quantidadeCartasDescobertas += 1
			GlobalJogoMemoria.qtdCartasViradas = 0
			print("deletou carta")
			print(GlobalJogoMemoria.quantidadeCartasDescobertas)

func VirarCarta(carta, ultimaCartaVirada):
	for children in get_children():
		if carta.get_node("Card" + carta.cartaAnimacao).visible:
			print("qualquer coisa 2")
			carta.get_node("Animacoes").play("DesvirarCarta" + carta.cartaAnimacao)
			ultimaCartaVirada.get_node("Animacoes").play("DesvirarCarta" + ultimaCartaVirada.cartaAnimacao)
			GlobalJogoMemoria.qtdCartasViradas = 0
