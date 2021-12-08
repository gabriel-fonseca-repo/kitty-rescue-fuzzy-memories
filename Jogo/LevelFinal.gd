extends Node2D

signal toggle_movement
signal final_dialogue_start

func _ready():
	emit_signal("final_dialogue_start") 
	emit_signal("toggle_movement") 
	$Lvl4.play()
	Global.lvl3 = false
	Global.lvl4 = true
	Global.health = 7
	Global.gato = 3
	if Global.tryagain:
		Global.health = 3
		Global.tryagain = false




func _on_DialogueBox_arena_dialogue_pt1_finished():
	$Lvl4.stop()
	$BossSong.play()


func _on_DialogueBox_arena_dialogue_pt2_finished():
	get_tree().change_scene("res://Jogo/EndingScreen.tscn")
