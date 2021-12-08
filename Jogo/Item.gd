extends StaticBody2D

var perto = false
var medio = false
var longe = false

func _ready():
	pass # Replace with function body.

#func _on_Item_body_entered(body):
#	if body.name == "Bruxinha":
#		body.hp += 1
#		queue_free()

func despawn_item():
	get_parent().itemOn = false
	Socket.write_text("Zero\n")
	Socket.write_text("Vibra0\n")
	
	queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Bruxinha":
		body.oneup()
		if Global.health < 10 and Global.health  > 0:
			
			Global.health += 1
		get_parent().itemOn = false
		Socket.write_text("Zero\n")
		Socket.write_text("Vibra0\n")
		
		queue_free()


func _on_Raio1_body_entered(body):
	if body.name == "Bruxinha":
		Socket.write_text("Vibra100\n")
		perto = true


func _on_Raio2_body_entered(body):
	if body.name == "Bruxinha":
		Socket.write_text("Vibra60\n")
		medio = true


func _on_Raio3_body_entered(body):
	if body.name == "Bruxinha":
		Socket.write_text("Vibra30\n")
		longe = true


func _on_Raio1_body_exited(body): #saiu do verde, ficando apenas amarelo e vermelho
	if body.name == "Bruxinha":
		if medio and longe:
			Socket.write_text("Vibra60\n")
		if !medio and !longe:
			Socket.write_text("Vibra0\n")
		perto = false


func _on_Raio2_body_exited(body): #saiu do amarelo, ficando só vermelho
	if body.name == "Bruxinha":
		if !medio and longe:
			Socket.write_text("Vibra30\n")
		if !medio and !longe:
			Socket.write_text("Vibra0\n")
		medio = false




func _on_Raio3_body_exited(body): #saiu do vermelho, apagando todos
	if body.name == "Bruxinha":
		Socket.write_text("Vibra0\n")
