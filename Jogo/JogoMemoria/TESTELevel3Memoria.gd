extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Bruxinha.position.x = 470
	$Bruxinha.position.y = 350
	$ChickBoyMemoria.position.x = 640
	$ChickBoyMemoria.position.y = 350
	$Cat.visible = true
	$Cat2.visible = true
	$Cat3.visible = true
	$CameraLevel3.current = true
	$DialogueBox2.level3_victory()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
