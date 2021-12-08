extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ChickBoyFinal = preload("res://Jogo/ChickBoyFinal.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	play("default")
	yield(get_tree().create_timer(1), "timeout")	
	var ChickBoy2 = ChickBoyFinal.instance()
	ChickBoy2.position = position
	get_parent().add_child(ChickBoy2)
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
