extends KinematicBody2D

var health = 7
var velocity = Vector2.ZERO
var mv_speed = 40
var mv_direction = 1
var player_detected = false
var attack_trigger = false
var hurt_trigger = false
var NewCat = false
var canHitBruxinha = false
var dialogue1 = false
var dialogue2 = false
var dialogue3 = false
var attack_animations = ["Attack1", "Attack2", "Attack3"]
onready var Bruxinha = get_parent().get_node("Bruxinha")
onready var CatFight = get_parent().get_node("CatFight")
onready var CatTransform = get_parent().get_node("CatTransform")
signal dialogue_play
signal enable_exit
const dialoguescene = preload("res://Jogo/DialogueBox.tscn")

func _ready():
	get_parent().get_node("LvlSong").stop()
	CatFight.play()
	
func _physics_process(delta):
	if !NewCat:
		if player_detected:
			if attack_trigger == false and hurt_trigger==false:
				$CatKnightSprite.play("Walk")
			if position.x < Bruxinha.position.x:
				$CatKnightSprite.flip_h = false
				$Collision_Idle.scale.x = 1
				mv_direction = 1
			elif position.x > Bruxinha.position.x:
				$CatKnightSprite.flip_h = true
				$Collision_Idle.scale.x = -1
				mv_direction = -1
			if Bruxinha.position.y < position.y:
				velocity.y = -mv_speed 
			elif Bruxinha.position.y > position.y:
				velocity.y = mv_speed
			if Bruxinha.position.x < position.x:
				velocity.x = -mv_speed 
			elif Bruxinha.position.x > position.x:
				velocity.x = mv_speed
		if player_detected == false and attack_trigger == false and hurt_trigger == false:
			$CatKnightSprite.play("Idle")
		velocity = move_and_slide(velocity)

func TomouDano():
	attack_trigger = false
	player_detected = false
	hurt_trigger = true
	health -= 1
	velocity = Vector2.ZERO
	$CatKnightSprite.play("Hurt")
	$Hurt.play()
	if health <= 0:
		if !NewCat:
			$CatKnightSprite.play("Death")
			$Dead.play()
	else:
		knockback()
		yield(get_tree().create_timer(0.7), "timeout")
		print(health)
		hurt_trigger = false
		player_detected = true
		

func attack():
	if attack_trigger:
		$AttackRange/AttackRanger.disabled = false
		if canHitBruxinha and !hurt_trigger:
			play_random_attack_anim()
			get_node("../Bruxinha").LevouDano()
			yield(get_tree().create_timer(2), "timeout")
			if canHitBruxinha:
				attack()

func play_random_attack_anim():
	var anim_id = randi() % attack_animations.size()
	var animation_name = attack_animations[anim_id]
	$CatKnightSprite.play(animation_name)
	if animation_name == "Attack1":
		$Attack1.play()
	if animation_name == "Attack2":
		$Attack2.play()
	if animation_name == "Attack3":
		$Attack3.play()
	yield(get_tree().create_timer(1), "timeout")

func _on_AttackTrigger_body_entered(body):
	if body.name == "Bruxinha" and !hurt_trigger:
		attack_trigger = true
		attack()

func knockback():
	velocity.x =  mv_speed * mv_direction * -1
	velocity = move_and_slide(velocity)

func _on_PlayerDetector_body_entered(body):
	if body.name == "Bruxinha":
		print("player detected")
		player_detected = true

func _on_PlayerDetector_body_exited(body):
	if body.name == "Bruxinha":
		player_detected = false
		velocity = Vector2.ZERO

func _on_CatKnightSprite_animation_finished():
	if $CatKnightSprite.animation == "Death":
		$CatKnightSprite.play("Puff")
		$Puff.play()
		Bruxinha.proxEstagio = true
		if get_parent().name == "Level1":
			get_parent().get_node("BarrierExit")._on_Bruxinha_next_level()
		if get_parent().name == "Level3":
			get_parent().get_node("BarrierExit")._on_Bruxinha_next_level()
	if $CatKnightSprite.animation == "Puff":
		$CatKnightSprite.play("Transform")
		$Collision_Idle.disabled = true
		$PlayerDetector/PlayerDetector.disabled = true
		$AttackTrigger/AttackTrigger.disabled = true
		NewCat = true
		Bruxinha.gatos += 1
		Global.gato += 1
		CatFight.stop()
		CatTransform.play()
		emit_signal("dialogue_play")
		emit_signal("enable_exit")
		if dialogue1:
			print("oi")
			play_dialogue_1()
		if dialogue2:
			play_dialogue_2()
		if dialogue3:
			play_dialogue_3()
	if $CatKnightSprite.animation == "Attack1" or $CatKnightSprite.animation == "Attack2" or $CatKnightSprite.animation == "Attack3":
#		canHitBruxinha = true
		$CatKnightSprite.play("Walk")

func _on_AttackRange_body_entered(body):
	if body.name == "Bruxinha":
		canHitBruxinha = true

func _on_AttackRange_body_exited(body):
	if body.name == "Bruxinha":
		canHitBruxinha = false

func play_dialogue_1():
	var current_scene = dialoguescene.instance()
	get_tree().get_root().get_node("Level1/CatKnight/DialogueBoxPosition").add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	current_scene._on_CatKnight_dialogue_play_1()

func play_dialogue_2():
	var current_scene = dialoguescene.instance()
	get_tree().get_root().get_node("Level2/CatKnight/DialogueBoxPosition").add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	current_scene._on_CatKnight_dialogue_play_2()

func play_dialogue_3():
	var current_scene = dialoguescene.instance()
	get_tree().get_root().get_node("Level3/CatKnight/DialogueBoxPosition").add_child(current_scene)
	get_tree().set_current_scene(current_scene)
	current_scene._on_CatKnight_dialogue_play_3()

func _on_Level1_level1dialogue():
	dialogue1 = true
	print(dialogue1)

func _on_Level2_level2dialogue():
	dialogue2 = true

func _on_Level3_level3dialogue():
	dialogue3 = true
