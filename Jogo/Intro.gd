extends Node2D
signal toggle_movement
signal dialogue_start

func _ready():
	$IntroSong.play()
	emit_signal("toggle_movement")
	#a bruxinhaficará com canmove = false na intro
	emit_signal("dialogue_start")
	#caixa de dialogo aparece

func _on_AreaProgredir_body_entered(body):
	if body.name == "Bruxinha":
		$IntroSong.stop()
		get_tree().change_scene("res://Jogo/Level1.tscn")
