extends KinematicBody2D

var InimigoHP = 50
var velocity = Vector2.ZERO
var mv_speed = 60
var mv_direction = 1
var isMorrendo = false
onready var Bruxinha = get_parent().get_node("Bruxinha")

func _physics_process(delta):
	if !isMorrendo:
		Bruxinha = get_parent().get_node("Bruxinha")
		if Bruxinha.position.y < position.y:
			velocity.y = -mv_speed
		elif Bruxinha.position.y > position.y:
			velocity.y = mv_speed
		if Bruxinha.position.x < position.x:
			velocity.x = -mv_speed
		elif Bruxinha.position.x > position.x:
			velocity.x = mv_speed
		if position.x < Bruxinha.position.x:
			$SpriteInimigo.flip_h = true
			$ColisaoInimigo.scale.x = 1
			mv_direction = -1
		elif position.x > Bruxinha.position.x:
			$SpriteInimigo.flip_h = false
			$ColisaoInimigo.scale.x = -1
		velocity = move_and_slide(velocity)
		if velocity.x != 0 and velocity.y != 0:
			$SpriteInimigo.play("Walk")

func TomarDano():
	print("tomoudano")
	InimigoHP -= 50
	$Hurt.play()
	print(InimigoHP)
	if InimigoHP <= 0:
		$AreaColisao.monitoring = false
		$ColisaoInimigo.disabled = true
		$AreaColisao/ColisaoInimigo.disabled = true
		isMorrendo = true
		$SpriteInimigo.play("Death")
		$Dead.play()
		Bruxinha.contadorInimigos += 1

func _on_SpriteInimigo_animation_finished():
	if $SpriteInimigo.animation == "Death":
		queue_free()

func _on_AreaColisao_body_entered(body):
	if body.name == "Bruxinha":
		body.LevouDano()
