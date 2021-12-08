extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var anim = get_node("AnimationPlayer").get_animation("moveEars")
	anim.set_loop(true)
	get_node("AnimationPlayer").play("moveEars")
	$Restart.grab_focus()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D2_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("leave")


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		print("start")
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
	get_tree().change_scene("res://Jogo/Abertura.tscn")


func _on_Quit_pressed():
	get_tree().quit()
