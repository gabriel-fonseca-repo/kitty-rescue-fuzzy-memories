extends KinematicBody2D

var cartaVirada = false
var cartaAnimacao = ""
var nomeCarta = ""
var canInteract = true
var a = 1
signal DeletarCarta
signal VirarCarta

func _ready():
	randomize()

func _process(delta):
	if GlobalJogoMemoria.lvl1 or GlobalJogoMemoria.lvl3:
		a = 1 - GlobalJogoMemoria.value
		modulate = Color(1, 1, 1, a)
	
			
func _on_Deteccao_body_entered(body):
	if canInteract:
		if body.name == "AtivacaoCarta" and !cartaVirada and GlobalJogoMemoria.qtdCartasViradas < 2:
			$Animacoes.play("VirarCarta" + cartaAnimacao)
			GlobalJogoMemoria.qtdCartasViradas += 1
			if cartaAnimacao == GlobalJogoMemoria.ultimaCartaVirada and GlobalJogoMemoria.qtdCartasViradas > 1:
				emit_signal("DeletarCarta", nomeCarta)
#				print("deletou carta")
				$Correct.play()
			if GlobalJogoMemoria.qtdCartasViradas < 2:
				GlobalJogoMemoria.ultimaCartaVirada = cartaAnimacao
				GlobalJogoMemoria.objCartaVirada = self
			cartaVirada = true
		elif body.name == "AtivacaoCarta" and cartaVirada:
			if GlobalJogoMemoria.qtdCartasViradas == 1:
				GlobalJogoMemoria.ultimaCartaVirada = ""
			$Animacoes.play("DesvirarCarta" + cartaAnimacao)
			cartaVirada = false
			

func _on_Animacoes_animation_finished(anim_name):
#	print(GlobalJogoMemoria.qtdCartasViradas)
	if anim_name == "VirarCarta" + cartaAnimacao:
		if cartaAnimacao != GlobalJogoMemoria.ultimaCartaVirada and GlobalJogoMemoria.qtdCartasViradas == 2:
			emit_signal("VirarCarta", self, GlobalJogoMemoria.objCartaVirada)
	if anim_name == "DesaparecerCarta" + cartaAnimacao:
		queue_free()
		GlobalJogoMemoria.qtdCartasViradas = 0
	if anim_name == "DesvirarCarta" + cartaAnimacao:
		cartaVirada = false
	canInteract = true

func _on_Animacoes_animation_started(anim_name):
	canInteract = false
