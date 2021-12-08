extends Control

var baixo = false
var cima = false

func _ready():
	$GameOverSong.play()
	$TryAgain.grab_focus()

#	Socket.connect("cima", self, "Cima")
#	Socket.connect("baixo", self, "Baixo")
#	Socket.connect("ataque", self, "Selecionar")

#func Cima():
#	if baixo:
#		$TryAgain.grab_focus()
#		baixo = false
#	if !cima:
#
#		cima = true
#
#func Baixo():
#	if cima:
#		$Quit.grab_focus()
#		cima = false
#	if !baixo:
#
#		baixo = true
#
#func Selecionar():
#	if cima:
#		Global.tryagain = true
#		if Global.lvl1:
#			get_tree().change_scene("res://Level1.tscn")
#		if Global.lvl2:
#			get_tree().change_scene("res://Level2.tscn")
#		if Global.lvl3:
#			get_tree().change_scene("res://Level3.tscn")
#		if Global.lvl4:
#			get_tree().change_scene("res://LevelFinal.tscn")
#	if baixo:
#		get_tree().quit()
#	cima = false
#	baixo = false

func _on_TryAgain_pressed():
	$Select.play()
	Global.tryagain = true
	if Global.lvl1:
		get_tree().change_scene("res://Jogo/Level1.tscn")
	if Global.lvl2:
		get_tree().change_scene("res://Jogo/Level2.tscn")
	if Global.lvl3:
		get_tree().change_scene("res://Jogo/Level3.tscn")
	if Global.lvl4:
		get_tree().change_scene("res://Jogo/LevelFinal.tscn")


func _on_Quit_pressed():
	get_tree().quit()
