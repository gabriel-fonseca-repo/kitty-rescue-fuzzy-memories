extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox._on_Intro_dialogue_start()
	$Bruxinha.intro_movement()

func _on_Bruxinha_level_transition():
	get_tree().change_scene("res://Jogo/JogoMemoria/Level1Memoria.tscn")
