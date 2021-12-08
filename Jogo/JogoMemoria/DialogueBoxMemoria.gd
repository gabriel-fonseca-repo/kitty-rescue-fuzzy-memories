extends Control
signal intro_dialogue_finished #enviar esse sinal pra mexer a bruxa automaticamente
signal lvl_dialogue_finished #enviar esse sinal pra canmove = true da bruxa e pra queue_free() no gato
signal arena_dialogue_pt1_finished #enviar esse sinal pra começar boss fight
signal arena_dialogue_pt2_finished #enviar esse sinal pra final do jogo
signal chickboy_disappear #chickboy desaparece após última fala
signal level1_dialogue_finished #MEMORIA
signal level1_mechanics_explained #MEMORIA
signal level1_Kitty_finished #MEMORIA
signal level2_mechanics_explained #MEMORIA
signal level3_mechanics_explained #MEMORIA
signal end_game #MEMORIA

func _ready():
	pass # Replace with function body.


func _on_Intro_dialogue_start(): #MEMORIA
	$Carta.visible = true
	$Intro1.visible = true
	$PortraitChickBoyCarta.visible = true
	$AnimationPlayer.play("Intro1")
	yield(get_tree().create_timer(9.0), "timeout")
	$Intro1.visible = false
	$Intro2.visible = true
	$AnimationPlayer.play("Intro2")
	yield(get_tree().create_timer(9.0), "timeout")
	$Carta.visible = false
	$Intro2.visible = false
	$PortraitChickBoyCarta.visible = false
	$ColorRect.visible = true
	$PortraitBruxinha.visible = true
	$Intro3.visible = true
	$AnimationPlayer.play("Intro3")
	yield(get_tree().create_timer(5.0), "timeout")
	$ColorRect.visible = false
	$PortraitBruxinha.visible = false
	$Intro3.visible = false
	emit_signal("intro_dialogue_finished") 	#isso vai fazer a bruxinha andar automaticamente pra cima
	
#func level1_start(): #MEMORIA
#	print("chick boy falando")
#	$ColorRect.visible = true
#	$Level1.set_visible(true)
#	$PortraitChickBoy.visible = true
#	$AnimationPlayer.play("Level1")
#	yield(get_tree().create_timer(7.0), "timeout")
#	$ColorRect.visible = false
#	$Level1.visible = false
#	$PortraitChickBoy.visible = false
#	emit_signal("level1_dialogue_finished")
	
func level1_intro(): #MEMORIA
	$ColorRect.visible = true
	$Level1.set_visible(true)
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("Level1")
	get_node("../ChickBoyMemoria/HurtFx").play()
	

func level1_mechanics_explained(): #MEMORIA
	$ColorRect.visible = true
	$Level1b.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("Level1b")
	

	
func level1_victory(): #MEMORIA
	get_node("../Bruxinha").canMove = false
#	get_node("../ChickBoyMemoria/CameraChickBoy").current = true
	$ColorRect.visible = true
	$Level1d.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("Level1d")
	get_node("../ChickBoyMemoria/HurtFx").play()


	
func level2_mechanics_explained(): #MEMORIA
	get_node("../Bruxinha").canMove = false
	get_node("../ChickBoyMemoria/CameraChickBoy").current = true
	$ColorRect.visible = true
	$Level2.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("Level2")
	get_node("../ChickBoyMemoria/HurtFx").play()
	
func level2_victory():
	get_node("../Bruxinha").canMove = false
	get_node("../ChickBoyMemoria/CameraChickBoy").current = true
	$ColorRect.visible = true
	$Level2b.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("Level2b")
	get_node("../ChickBoyMemoria/HurtFx").play()

	
func level3_mechanics_explained(): #MEMORIA
	get_node("../Bruxinha").canMove = false
	get_node("../ChickBoyMemoria/CameraChickBoy").current = true
	$ColorRect.visible = true
	$Level3.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("Level3")
	get_node("../ChickBoyMemoria/HurtFx").play()
	

	
	
func level3_victory():
	get_node("../Bruxinha").canMove = false
	get_node("../CameraFinal").current = true
#	get_node("../ChickBoyMemoria/CameraChickBoy").current = true
	$ColorRect.visible = true
	$Level3b.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("Level3b")
	get_node("../ChickBoyMemoria/HurtFx").play()
	




func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Level1":
		$ColorRect.visible = false
		$Level1.visible = false
		$PortraitChickBoy.visible = false
		get_node("../Bruxinha").canMove = true
		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
		get_node("../Bruxinha/CameraBruxinha").current = true
		get_node("../Bruxinha").canMove = true
	if anim_name == "Level1b":
		$Level1b.visible = false
		$PortraitBruxinha.visible = false
		$Level1c.visible = true
		$PortraitChickBoy.visible = true
		$AnimationPlayer.play("Level1c") #chick boy explica as mecânicas
		get_node("../ChickBoyMemoria/HurtFx").play()
	if anim_name == "Level1c":
		$Level1c.visible = false
		$PortraitChickBoy.visible = false
		$ColorRect.visible = false
		$AnimationPlayer.play("Level1c")
		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
		get_node("../Bruxinha/CameraBruxinha").current = true
		get_node("../Bruxinha").canMove = true
		emit_signal("level1_mechanics_explained")
#		GlobalJogoMemoria.comecarTimer = true
	if anim_name == "Level1d":
		$Level1d.visible = false
		$PortraitChickBoy.visible = false
		$ColorRect.visible = false
#		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
#		get_node("../Bruxinha/CameraBruxinha").current = true
		get_node("../Bruxinha").canMove = true
	if anim_name == "Level2":
		$ColorRect.visible = false
		$Level2.visible = false
		$PortraitChickBoy.visible = false
		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
		get_node("../Bruxinha/CameraBruxinha").current = true
		get_node("../Bruxinha").canMove = true
		GlobalJogoMemoria.comecarTimer = true
	if anim_name == "Level2b":
		$ColorRect.visible = false
		$Level2b.visible = false
		$PortraitChickBoy.visible = false
		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
		get_node("../Bruxinha/CameraBruxinha").current = true
		get_node("../Bruxinha").canMove = true	
	if anim_name == "Level3":
		$ColorRect.visible = false
		$Level3.visible = false
		$PortraitChickBoy.visible = false	
		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
		get_node("../CameraLevel3").current = true
		get_node("../Bruxinha").canMove = true	
		GlobalJogoMemoria.comecarTimer = true
	if anim_name == "Level3b":
#		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
#		get_node("../Bruxinha/CameraBruxinha").current = true
#		get_node("../Bruxinha").create_dialogue_box()
		$Level3b.visible = false
		$PortraitChickBoy.visible = false
		$Level3c.visible = true
		$PortraitBruxinha.visible = true
		$AnimationPlayer.play("Level3c") #kitty fala
	if anim_name == "Level3c":
#		get_node("../ChickBoyMemoria/CameraChickBoy").current = true
		$Level3c.visible = false
		$PortraitBruxinha.visible = false
		$Level3d.visible = true
		$PortraitChickBoy.visible = true
		$AnimationPlayer.play("Level3d") #chickboy fala
	if anim_name == "Level3d":
#		get_node("../ChickBoyMemoria/CameraChickBoy").current = false
#		get_node("../Bruxinha/CameraBruxinha").current = true
		get_node("../ChickBoyMemoria").disappear()
		$Level3d.visible = false
		$PortraitChickBoy.visible = false
		$Level3e.visible = true
		$PortraitBruxinha.visible = true
		$AnimationPlayer.play("Level3e") #kitty fala
	if anim_name == "Level3e":
		$ColorRect.visible = false
		$Level3e.visible = false
		$PortraitBruxinha.visible = false
		GlobalJogoMemoria.speedRunUnlocked = true
		get_tree().change_scene("res://Jogo/EndingScreen.tscn")
		emit_signal("arena_dialogue_pt2_finished")
