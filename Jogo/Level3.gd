extends Node2D

var Bruxa
var Pumpkin
var Slime
var Frog
var CatKnight
var canSpawnAgain = true
var random
var random_position
var itemOn = false
var vibration_strength
var Item
signal level3dialogue
signal testedialogo
signal toggle_movement

func _ready():
	emit_signal("level3dialogue")
	emit_signal("toggle_movement") 
	$ChangeLvl.play()
	Item = load ("res://Jogo/Item.tscn")
	randomize()
	
	Socket.write_text("Zero\n")
	Socket.write_text("Reset\n")
	
	Bruxa = load("res://Jogo/Bruxa.tscn")
	Pumpkin = load("res://Jogo/Pumpkin.tscn")
	Slime = load("res://Jogo/Slime.tscn")
	Frog = load("res://Jogo/Frog.tscn")
	CatKnight = load("res://Jogo/CatKnight.tscn")
	randomize()
	$LvlSong.play()
	Global.lvl2 = false
	Global.lvl3 = true
	if Global.tryagain:
		Global.health = 3
		Global.tryagain = false

func spawn_item():
	var itemp1 = Vector2(250,-96)
	var itemp2 = Vector2(-100,50)
	var itemp3 = Vector2(60,-230)
	var position_array = [itemp1, itemp2, itemp3]
	var item = Item.instance()
	
	random_position = rand_range(0,3)
	item.position.x = position_array[random_position].x
	item.position.y = position_array[random_position].y
	
	add_child(item)
	itemOn = true

#func _process(delta):
#	if itemOn:
#		var Bruxinha = get_node("Bruxinha")
#		var Item = get_node("Item")
#		var distancia = Item.global_position.distance_to(Bruxinha.global_position)
##		if distancia > 200:
##			Socket.write_text("Zero\n")
#		if distancia <= 200 and distancia > 150:
##			print("90 perto")
#			Socket.write_text("Red\n")
#			vibration_strength = distancia/2
#			Socket.write_text("Vibrar\n"+str(vibration_strength))
#
#		elif distancia <= 150 and distancia > 100:
##			print("60 perto")
#			Socket.write_text("Yellow\n")
#			vibration_strength = distancia/2
#			Socket.write_text("Vibrar\n"+str(vibration_strength))
#
#		if distancia <= 100:
##			print("30 perto")
#			Socket.write_text("Green\n")
#			vibration_strength = distancia/2
#			Socket.write_text("Vibrar\n"+str(vibration_strength))
			

func SpawnarInimigos():
	var inimigos = [Bruxa, Pumpkin, Slime]
	random = rand_range(0, 3)
	var inimigo1 = inimigos[random].instance()
	random = rand_range(0, 3)
	var inimigo2 = inimigos[random].instance()
	random = rand_range(0, 3)
	var inimigo3 = inimigos[random].instance()
	
	inimigo1.position.x = 260
	inimigo1.position.y = -90
	
	inimigo2.position.x = 175
	inimigo2.position.y = 70
	
	inimigo3.position.x = 30
	inimigo3.position.y = -196
	
	add_child(inimigo1)
	add_child(inimigo2)
	add_child(inimigo3)

func _on_AreaProgredir_body_entered(body):
	if body.name == "Bruxinha":
			get_tree().change_scene("res://Jogo/Level3.tscn")

func _on_Spawn_body_entered(body):
	if canSpawnAgain:
		if body.name == "Bruxinha":
			SpawnarInimigos()
			canSpawnAgain = false

func _on_Bruxinha_spawn_miniboss():
	var miniboss = CatKnight.instance()
	miniboss.position.x = 280
	miniboss.position.y = -100
	add_child(miniboss)
	miniboss.dialogue3 = true



