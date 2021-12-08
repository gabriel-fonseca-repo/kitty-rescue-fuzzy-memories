extends Area2D


var move = Vector2.ZERO
var look_vec = Vector2.ZERO #esquerda
var player = null
var speed = 5


func _ready():
	look_vec = player.position - global_position
	var angleTo = $AnimatedSprite.transform.x.angle_to(look_vec)
	$AnimatedSprite.rotate(sign(angleTo) * min(100, abs(angleTo)))
	

func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vec, delta)
	move = move.normalized() * speed
	position += move


func _on_Area2D_body_entered(body):
	if body.name == "Bruxinha":
		body.LevouDano()
