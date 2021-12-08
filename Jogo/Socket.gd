extends Node

var client
var wrapped_client
var connected = false

var text = ""

signal esquerda()
signal direita()
signal ponto_morto()
signal ataque()
signal baixo()
signal cima()
signal verde()
signal azul()
signal vermelho()
signal amarelo()
signal ok()
signal errou()
signal naoAtaque()

func _ready():
	client = StreamPeerTCP.new()
	client.set_no_delay(true)
	connect_to_server() #chama automaticamente se já estiver tudo configurado no esp, sem precisar de botão
	
func _exit_tree():
	disconnect_from_server()

func connect_to_server():
	var ip = "192.168.43.242"
	var port = 80
	print("Connecting to server: %s : %s" % [ip, str(port)])
	var connect = client.connect_to_host(ip, port)
	if client.is_connected_to_host():
		connected = true
		print("Connected!")
	
func disconnect_from_server():
	connected = false
	client.disconnect_from_host()

func _process(delta):
	if not connected:
		pass
	if connected and not client.is_connected_to_host():
		connected = false
	if client.is_connected_to_host():
		poll_server()


func poll_server():
	while client.get_available_bytes() > 0:
		var msg = client.get_utf8_string(client.get_available_bytes())
		if msg == null:
			continue;
			
		if msg.length() > 0:
			for c in msg:
				if c == "\n":
					on_text_received(text)
					text = "" #limpa a string
				else:
					text+=c #vai concatenando a string

func on_text_received(text): #"1 Sobe"
	var command_array = text.split(" ")
	print(command_array[0])
#	if command_array.size() < 2:
#		return
		
	if str(command_array[0]) == "DIREITA":
		emit_signal("direita") #command_array[0])
	if str(command_array[0]) == "ESQUERDA":
		emit_signal("esquerda") #command_array[0])
	if str(command_array[0]) == "PONTOMORTO":
		emit_signal("ponto_morto")
	if str(command_array[0]) == "ATAQUE":
		emit_signal("ataque")	
	if str(command_array[0]) == "BAIXO":
		emit_signal("baixo")
	if str(command_array[0]) == "CIMA":
		emit_signal("cima")
	if str(command_array[0]) == "AZUL":
		emit_signal("azul")
	if str(command_array[0]) == "VERMELHO":
		emit_signal("vermelho")	
	if str(command_array[0]) == "VERDE":
		emit_signal("verde")
	if str(command_array[0]) == "AMARELO":
		emit_signal("amarelo")
	if str(command_array[0]) == "OK":
		emit_signal("ok")
	if str(command_array[0]) == "ERROU":
		emit_signal("erro")
	if str(command_array[0]) == "NAOATAQUE":
		emit_signal("naoAtaque")

#função para enviar comandos pro ESP32:
func write_text(text):
	if connected and client.is_connected_to_host():
		print("Sending: %s" % text)
		client.put_data(text.to_ascii())
