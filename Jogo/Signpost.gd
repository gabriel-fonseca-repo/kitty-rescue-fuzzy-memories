extends Area2D

var enable_puzzle = false


func _ready():
	$ColorRect.visible = false
	Socket.connect("azul", self, "azul_pressed")
	Socket.connect("vermelho", self, "vermelho_pressed")
	Socket.connect("verde", self, "verde_pressed")
	Socket.connect("amarelo", self, "amarelo_pressed")
	Socket.connect("ok", self, "puzzle_solved")
	Socket.connect("erro", self, "error")


func _on_Signpost_body_entered(body):
	if body.name == "Bruxinha":
		if body.proxEstagio:
			enable_puzzle = true
			print(enable_puzzle)
			$ColorRect.visible = true
			yield(get_tree().create_timer(7), "timeout")
			$ColorRect.visible = false
		
func puzzle_solved():
	print("resolvido")
	$SolvedFx.play()
	yield(get_tree().create_timer(3), "timeout")
	queue_free()
	
func error():
	$ErrorFx.play()
		
func azul_pressed():
	if enable_puzzle:
		Socket.write_text("ERRO\n")
	
func vermelho_pressed():
	if enable_puzzle:
		Socket.write_text("ERRO\n")

func verde_pressed():
	if enable_puzzle:
		print("botão verde")
		Socket.write_text("ACERTO\n")

func amarelo_pressed():
	if enable_puzzle:
		Socket.write_text("ERRO\n")
