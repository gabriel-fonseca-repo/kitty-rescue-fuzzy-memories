extends Node

var qtdCartasViradas = 0
var ultimaCartaVirada = "Nenhuma"
var objCartaVirada
var quantidadeCartasDescobertas = 0
var passarFase = false
var value = 0
var comecarTimer = false
var speedRunUnlocked = false
var speedRunMode = false

var lvl1 = false
var lvl2 = false
var lvl3 = false
var lvl4 = false
var tryagain = false

func _process(delta):
	if Input.is_action_just_pressed("neuro01"):
		value = 0.0
		if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:		
			Socket.write_text("Vibra0\n")
#			get_node("../Bruxinha").mv_speed * (1-GlobalJogoMemoria.value)
	if Input.is_action_just_pressed("neuro02"):
		value = 0.2
		if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
			Socket.write_text("Vibra20\n")
#			get_node("../Bruxinha").mv_speed * (1-GlobalJogoMemoria.value)
	if Input.is_action_just_pressed("neuro03"):
		value = 0.4
		if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
			Socket.write_text("Vibra40\n")
#			get_node("../Bruxinha").mv_speed * (1-GlobalJogoMemoria.value)
	if Input.is_action_just_pressed("neuro04"):
		value = 0.6
		if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
			Socket.write_text("Vibra60\n")	
#			get_node("../Bruxinha").mv_speed * (1-GlobalJogoMemoria.value)
	if Input.is_action_just_pressed("neuro05"):
		value = 0.8
		if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:		
			Socket.write_text("Vibra80\n")	
	if Input.is_action_just_pressed("neuro06"):
		value = 1.0
		if GlobalJogoMemoria.lvl2 or GlobalJogoMemoria.lvl3:
			Socket.write_text("Vibra100\n")
#			get_node("../Bruxinha").mv_speed * (1-GlobalJogoMemoria.value)
