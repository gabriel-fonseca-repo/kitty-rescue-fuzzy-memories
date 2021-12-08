extends KinematicBody2D

var canFlip = true
var canMove = true
var canIdle = true
var isDead = false
var mv_direction = 1
var mv_speed = 50
var velocity = Vector2.ZERO
var life = 5
var attackNum = 0
var isInsideRightAttackRange = false
var isInsideLeftAttackRange = false

var canFireAttack = true

onready var projectile_instance = preload("res://Jogo/Projectile.tscn")
onready var Bruxinha = get_parent().get_node("Bruxinha")
onready var Particle2 = preload("res://Jogo/particles2.tscn")

func _physics_process(delta):
	if !isDead:
		if canFlip:
			if position.x + 10 < Bruxinha.position.x:
				$Chick2Sprite.flip_h = false
				mv_direction = 1
			elif position.x - 10 > Bruxinha.position.x and position.x != Bruxinha.position.x:
				$Chick2Sprite.flip_h = true
				mv_direction = -1
		if canMove:
			$Chick2Sprite.play("Walk")
			if Bruxinha.position.y < position.y:
				velocity.y = -mv_speed 
			elif Bruxinha.position.y > position.y:
				velocity.y = mv_speed
			if Bruxinha.position.x < position.x:
				velocity.x = -mv_speed
			elif Bruxinha.position.x > position.x:
				velocity.x = mv_speed
			velocity = move_and_slide(velocity)
		if !canMove and !canFlip and canIdle:
			print("idle")
			$Chick2Sprite.play("Idle")
		if canFireAttack:
			if isInsideLeftAttackRange:
				FireAttack(true)
			elif isInsideRightAttackRange:
				FireAttack(false)
		

func TomarDano():
	if !isDead:
		life-=1
		$HurtFx.play()
		print(life)
		yield(get_tree().create_timer(0.5), "timeout")	
		canMove = false
		$Chick2Sprite.play("Hurt")
		yield(get_tree().create_timer(0.3), "timeout")
		canMove = true
		if life <= 0:
			$Chick2Sprite.play("Death")
			isDead = true
			$DeadFx.play()
			yield(get_tree().create_timer(2), "timeout")
			var particlesNode = Particle2.instance()
			particlesNode.position = position
			get_parent().add_child(particlesNode)
			queue_free()
			
func FireAttack(left):
	canFireAttack = false
	canMove = false
	canFlip = false
	canIdle = false
	$Chick2Sprite.play("Attack")
	$FireAreaFx.play()
	yield(get_tree().create_timer(0.2), "timeout")
	if left:
		if isInsideLeftAttackRange:
			Bruxinha.LevouDano()
	else:
		if isInsideRightAttackRange:
			Bruxinha.LevouDano()
	yield(get_tree().create_timer(4), "timeout")
	canIdle = true
	canMove = true
	canFlip = true
	$FireAttackCooldown.start()
	
func shoot():
	if canFireAttack:
		var projectile = projectile_instance.instance()
		projectile.position = get_global_position()
		projectile.player = Bruxinha
		get_parent().add_child(projectile)
		$FireFx.play()
		canMove = true
		mv_speed = 50
		yield(get_tree().create_timer(1.5), "timeout")	
		mv_speed = 30	


func _on_AttackTimer_timeout():
	if !isDead:
		shoot()






func _on_FireAttackCooldown_timeout():
	canFireAttack = true


func _on_AttackAreaRight_body_entered(body):
	if body.name == "Bruxinha":
		isInsideRightAttackRange = true
		if !isDead and canFireAttack:
			FireAttack(false)


func _on_AttackAreaRight_body_exited(body):
	if body.name == "Bruxinha":
		isInsideRightAttackRange = false

func _on_AttackAreaLeft_body_entered(body):
	if body.name == "Bruxinha":
		isInsideLeftAttackRange = true
		if !isDead and canFireAttack:
			FireAttack(true)

func _on_AttackAreaLeft_body_exited(body):
	if body.name == "Bruxinha":
		isInsideLeftAttackRange = false

