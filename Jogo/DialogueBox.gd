extends Control
signal intro_dialogue_finished #enviar esse sinal pra mexer a bruxa automaticamente
signal lvl_dialogue_finished #enviar esse sinal pra canmove = true da bruxa e pra queue_free() no gato
signal arena_dialogue_pt1_finished #enviar esse sinal pra começar boss fight
signal arena_dialogue_pt2_finished #enviar esse sinal pra final do jogo
signal chickboy_disappear #chickboy desaparece após última fala


func _ready():
	pass # Replace with function body.


func _on_Intro_dialogue_start():
	$ColorRect.visible = true
	$Intro1.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("Intro1")
	yield(get_tree().create_timer(9.0), "timeout")
	$Intro1.visible = false
	$Intro2.visible = true
	$AnimationPlayer.play("Intro2")
	yield(get_tree().create_timer(9.0), "timeout")
	$ColorRect.visible = false
	$Intro2.visible = false
	$PortraitBruxinha.visible = false
	emit_signal("intro_dialogue_finished") 	#isso vai fazer a bruxinha andar automaticamente pra cima
	
func _on_CatKnight_dialogue_play_1():
	print("executando dialogo")
	$ColorRect.visible = true
	$Level1.set_visible(true)
	print($Level1.is_visible())
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("Level1")
	yield(get_tree().create_timer(7.0), "timeout")
	$ColorRect.visible = false
	$Level1.visible = false
	$PortraitBruxinha.visible = false
	emit_signal("lvl_dialogue_finished")

func _on_CatKnight_dialogue_play_2():
	$ColorRect.visible = true
	$Level2.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("Level2")
	yield(get_tree().create_timer(7.0), "timeout")
	$ColorRect.visible = false
	$Level2.visible = false
	$PortraitBruxinha.visible = false
	emit_signal("lvl_dialogue_finished")

func _on_CatKnight_dialogue_play_3():
	$ColorRect.visible = true
	$Level3.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("Level3")
	yield(get_tree().create_timer(7.0), "timeout")
	$ColorRect.visible = false
	$Level3.visible = false
	$PortraitBruxinha.visible = false
	emit_signal("lvl_dialogue_finished")



func _on_LevelFinal_final_dialogue_start():
	$ColorRect.visible = true
	$ArenaChickBoy1.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("ArenaChickBoy1")
	yield(get_tree().create_timer(3.0), "timeout")
	$ArenaChickBoy1.visible = false
	$PortraitChickBoy.visible = false
	$ArenaKitty1.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("ArenaKitty1")
	yield(get_tree().create_timer(5.0), "timeout")
	$ArenaKitty1.visible = false
	$PortraitBruxinha.visible = false
	$ArenaChickBoy2.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("ArenaChickBoy2")
	yield(get_tree().create_timer(3.0), "timeout")
	$ArenaChickBoy2.visible = false
	$PortraitChickBoy.visible = false
	$ArenaKitty2.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("ArenaKitty2")
	yield(get_tree().create_timer(3.0), "timeout")
	$ArenaKitty2.visible = false
	$PortraitBruxinha.visible = false
	$ArenaChickBoy3.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("ArenaChickBoy3")
	yield(get_tree().create_timer(9.0), "timeout")
	$ArenaChickBoy3.visible = false
	$ArenaChickBoy4.visible = true
	$AnimationPlayer.play("ArenaChickBoy4")
	yield(get_tree().create_timer(10.0), "timeout")
	$ColorRect.visible = false
	$ArenaChickBoy4.visible = false
	$PortraitChickBoy.visible = false
	emit_signal("arena_dialogue_pt1_finished")
	queue_free()
	#começar boss fight
	
func _final_dialogue():
	$ColorRect.visible = true
	$ArenaChickBoy5.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("ArenaChickBoy5")
	yield(get_tree().create_timer(7.0), "timeout")
	$ArenaChickBoy5.visible = false
	$PortraitChickBoy.visible = false
	$ArenaKitty3.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("ArenaKitty3")
	yield(get_tree().create_timer(7.0), "timeout")
	$ArenaKitty3.visible = false
	$PortraitBruxinha.visible = false
	$ArenaChickBoy6.visible = true
	$PortraitChickBoy.visible = true
	$AnimationPlayer.play("ArenaChickBoy6")
	yield(get_tree().create_timer(7.0), "timeout")
	$ArenaChickBoy6.visible = false
	$PortraitChickBoy.visible = false
	emit_signal("chickboy_disappear")
	$ArenaKitty4.visible = true
	$PortraitBruxinha.visible = true
	$AnimationPlayer.play("ArenaKitty4")
	yield(get_tree().create_timer(7.0), "timeout")
	$ArenaKitty4.visible = false
	$PortraitBruxinha.visible = false
	$ColorRect.visible = false
	get_tree().change_scene("res://Jogo/EndingScreen.tscn")
	emit_signal("arena_dialogue_pt2_finished")
	
#	#sinalizando o final do jogo 
	
	



	

