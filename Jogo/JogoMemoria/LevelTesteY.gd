extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Bruxinha.position.x = 490
	$Bruxinha.position.y = 320
	$ChickBoyMemoria.position.x = 660
	$ChickBoyMemoria.position.y = 320
	$DialogueBox2.level3_victory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
