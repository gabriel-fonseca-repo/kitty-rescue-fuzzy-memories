extends Area2D

func _on_AreaProgredir_body_entered(body):
	if body.name == "Bruxinha":
		get_tree().change_scene("res://Jogo/Level3.tscn")
