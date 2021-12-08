extends KinematicBody2D
onready var Bruxinha = get_parent().get_node("Bruxinha")



func _ready():
	$ChickSprite.play("Idle")

func _physics_process(delta):
	if position.x + 10 < Bruxinha.position.x:
		$ChickSprite.flip_h = false
	elif position.x - 10 > Bruxinha.position.x:
		$ChickSprite.flip_h = true

func disappear():
	$Puff.play()
	$ChickSprite.play("Puff")
	

func _on_ChickSprite_animation_finished():
	if $ChickSprite.animation == "Puff":
		queue_free()
