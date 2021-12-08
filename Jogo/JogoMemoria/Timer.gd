extends RichTextLabel

var milisegundos = 0
var segundos = 0
var minutos = 0

func _process(delta):
	if segundos > 59:
		minutos += 1
		segundos = 0
	
		
#	if milisegundos < 1:
#		segundos -= 1
#		milisegundos = 10
#	if segundos < 1:
#		minutos -= 1
#		segundos = 59
#
	set_text("%02d:%02d" % [minutos, segundos])
#	set_text(str(minutos)+":"+str(segundos))
	
#	if minutos < 0:
#		get_tree().change_scene("res://JogoMemoria/GameOverMemoria.tscn")

func _on_Milisegundos_timeout():
	if GlobalJogoMemoria.comecarTimer:
		segundos += 1
