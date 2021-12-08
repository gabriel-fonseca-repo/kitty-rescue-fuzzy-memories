extends Node2D
signal toggle_movement
signal level1dialogue
var Bruxa
var Pumpkin
var Slime
var Frog
var CatKnight
var canSpawnAgain = true
var random
var Item
var random_position
var itemOn = false
var vibration_strength
var msg_sent1 = false
var msg_sent2 = false
var msg_sent3 = false
var msg_sent4 = false

func _ready():
	$ChangeLvl.play()
	emit_signal("toggle_movement") 
	Item = load ("res://Jogo/Item.tscn")
	randomize()
	
	Socket.write_text("Vibra0\n")
	Socket.write_text("Reset\n")
	
	Bruxa = load("res://Jogo/Bruxa.tscn")
	Pumpkin = load("res://Jogo/Pumpkin.tscn")
	Slime = load("res://Jogo/Slime.tscn")
	Frog = load("res://Jogo/Frog.tscn")
	CatKnight = load("res://Jogo/CatKnight.tscn")
	randomize()
	$LvlSong.play()
	Global.lvl1 = true
	if Global.tryagain:
		Global.health = 3
		Global.tryagain = false
#func _process(delta):
#	if itemOn:
#		var Bruxinha = get_node("Bruxinha")
#		var Item = get_node("Item")
#		var distancia = Item.global_position.distance_to(Bruxinha.global_position)
##		if distancia > 200:
##			Socket.write_text("Zero\n")
#		if distancia <= 200 and distancia > 150:
##			print("90 perto")
#			if !msg_sent1:
#				Socket.write_text("Vibrar30\n"+str(vibration_strength))
#				msg_sent1 = true
#			else:
#				msg_sent1 = false
#
#		elif distancia <= 150 and distancia > 100:
##			print("60 perto")
#			if !msg_sent2:
#				Socket.write_text("Vibrar60\n"+str(vibration_strength))
#				msg_sent2 = true
#			else:
#				msg_sent2 = false
#
#		if distancia <= 100:
##			print("30 perto")
#			if !msg_sent3:
#				Socket.write_text("Vibrar100\n"+str(vibration_strength))
#				msg_sent3 = true
#			else:
#				msg_sent3 = false

func SpawnarInimigos():
	var inimigos = [Bruxa, Pumpkin, Slime]
	random = rand_range(0, 3)
	var inimigo1 = inimigos[random].instance()
	random = rand_range(0, 3)
	var inimigo2 = inimigos[random].instance()
	random = rand_range(0, 3)
	var inimigo3 = inimigos[random].instance()
	
	inimigo1.position.x = 620
	inimigo1.position.y = 340
	
	inimigo2.position.x = 620
	inimigo2.position.y = 120
	
	inimigo3.position.x = 420
	inimigo3.position.y = 340
	
	add_child(inimigo1)
	add_child(inimigo2)
	add_child(inimigo3)

func _on_AreaProgredir_body_entered(body):
	if body.name == "Bruxinha":
			get_tree().change_scene("res://Jogo/Level2.tscn")

func _on_Spawn_body_entered(body):
	if canSpawnAgain:
		if body.name == "Bruxinha":
			SpawnarInimigos()
			canSpawnAgain = false

func _on_Bruxinha_spawn_miniboss():
	var miniboss = CatKnight.instance()
	miniboss.position.x = 620
	miniboss.position.y = 340
	add_child(miniboss)
	miniboss.dialogue1 = true

func spawn_item():
	var itemp1 = Vector2(435,90)
	var itemp2 = Vector2(620,120)
	var itemp3 = Vector2(420,340)
	var position_array = [itemp1, itemp2, itemp3]
	var item = Item.instance()
	
	random_position = rand_range(0,3)
	item.position.x = position_array[random_position].x
	item.position.y = position_array[random_position].y
	
	add_child(item)
	itemOn = true
