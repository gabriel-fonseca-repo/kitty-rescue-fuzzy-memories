extends KinematicBody2D

var canFlip = true
var canMove = false
var canShoot = false
var canIdle = true
var mv_direction = 1
var mv_speed = 50
var velocity = Vector2.ZERO
var life = 3

var shotAttack = true;

onready var projectile_instance = preload("res://Jogo/Projectile.tscn")
onready var Particle = preload("res://Jogo/particles.tscn")
onready var Bruxinha = get_parent().get_node("Bruxinha")

func _ready():
	canMove = false

func _physics_process(delta):
	if canFlip:
		if position.x + 10 < Bruxinha.position.x:
			$ChickSprite.flip_h = false
			mv_direction = 1
		elif position.x - 10 > Bruxinha.position.x:
			$ChickSprite.flip_h = true
			mv_direction = -1
	if canMove:
		$ChickSprite.play("Walk")
		if Bruxinha.position.y < position.y:
			velocity.y = -mv_speed 
		elif Bruxinha.position.y > position.y:
			velocity.y = mv_speed
		if Bruxinha.position.x < position.x:
			velocity.x = -mv_speed
		elif Bruxinha.position.x > position.x:
			velocity.x = mv_speed
		velocity = move_and_slide(velocity)
	if !canMove and canIdle:
		$ChickSprite.play("Idle")
		


func shoot():
	canIdle = false
	$ChickSprite.play("Attack")
	$FireFx.play()
	var projectile = projectile_instance.instance()
	projectile.position = get_global_position()
	projectile.player = Bruxinha
	get_parent().add_child(projectile)
	canIdle = true
	canMove = true
	mv_speed = 45
	yield(get_tree().create_timer(1.5), "timeout")	
	mv_speed = 20	
	


func _on_CoolDown_timeout():
	if canShoot:
		shoot()
		shotAttack = !shotAttack

func TomarDano():
	canShoot = false
	life-=1
	print(life)
	yield(get_tree().create_timer(0.5), "timeout")	
	canMove = false
	canIdle = false
	$ChickSprite.play("Hit")
	$HurtFx.play()
	yield(get_tree().create_timer(0.7), "timeout")
	canMove = true
	canIdle = true
	if life <= 0:
		nextLevel()
	canShoot = true

func nextLevel():
	var particlesNode = Particle.instance()
	particlesNode.position = position
	get_parent().add_child(particlesNode)
	queue_free()
	
func startFight():
	canShoot = true
	canMove = true
	canFlip = true




func _on_DialogueBox_arena_dialogue_pt1_finished():
	canShoot = true
	canMove = true
	canFlip = true
