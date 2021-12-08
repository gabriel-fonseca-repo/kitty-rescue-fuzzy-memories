extends Node2D

var cima = false
var baixo = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Socket.connect("cima", self, "Cima")
	Socket.connect("baixo", self, "Baixo")
	Socket.connect("ataque", self, "Selecionar")
	FinalSong.stop()
	var anim = get_node("AnimationPlayer").get_animation("moveEars")
	anim.set_loop(true)
	get_node("AnimationPlayer").play("moveEars")
	$OpSong.play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func Cima():
	if baixo:
		$Area2D2/closeanimation.play("ungrow")
		baixo = false
	if !cima:
		$Area2D/playanimation.play("grow")
		cima = true

func Baixo():
	if cima:
		$Area2D/playanimation.play("ungrow")
		cima = false
	if !baixo:
		$Area2D2/closeanimation.play("grow")
		baixo = true

func Selecionar():
	if cima:
		$OpSong.stop()
		get_tree().change_scene("res://Intro.tscn")
	if baixo:
		$OpSong.stop()
		get_tree().quit()
	cima = false
	baixo = false

func _on_Area2D2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		$Select.play()
		print("leave")
		$OpSong.stop()
		get_tree().quit()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("start")
		$OpSong.stop()
		get_tree().change_scene("res://Jogo/Intro.tscn")


func _on_Area2D_mouse_entered():
	$Area2D/playanimation.play("grow")


func _on_Area2D_mouse_exited():
	$Area2D/playanimation.play("ungrow")


func _on_Area2D2_mouse_entered():
	$Area2D2/closeanimation.play("grow")


func _on_Area2D2_mouse_exited():
	$Area2D2/closeanimation.play("ungrow")


func _on_Restart_pressed():
	get_tree().change_scene("res://Jogo/Intro.tscn")


func _on_Quit_pressed():
	get_tree().quit()
