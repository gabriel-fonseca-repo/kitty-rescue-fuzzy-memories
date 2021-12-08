extends Control
onready var Bruxinha = get_parent().get_node("Bruxinha")



func _physics_process(delta):
	$CanvasLayer/Life.text = String(Global.health)
	$CanvasLayer/Cat.text = String(Global.gato)
