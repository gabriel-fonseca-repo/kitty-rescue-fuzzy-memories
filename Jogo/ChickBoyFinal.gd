extends KinematicBody2D
signal finalsong
onready var Bruxinha = get_parent().get_node("Bruxinha")
onready var BossSong = get_parent().get_node("BossSong")
const dialoguescene = preload("res://Jogo/DialogueBox.tscn")

func _ready():
	BossSong.stop()
	FinalSong.play()
	$ChickSprite.play("Idle")
	var current_scene = dialoguescene.instance()
	get_tree().get_root().get_node("LevelFinal/ChickBoyFinal/Position2D").add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	current_scene._final_dialogue()

func _physics_process(delta):
	if position.x + 10 < Bruxinha.position.x:
		$ChickSprite.flip_h = false
	elif position.x - 10 > Bruxinha.position.x:
		$ChickSprite.flip_h = true
