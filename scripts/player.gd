extends CharacterBody2D

const speed = 100
var current_direction = "none"
var enemy_in_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true
var is_attacking = false



func _ready():
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta):
	player_movement(delta)
	enemy_attack()
	attack()
	current_camera()
	
	if health <=0:
		player_alive = false
		health = 0
		print("player has been killed")
	

func player_movement(delta):
	
	if Input.is_action_pressed("d_key"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("a_key"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("s_key"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("w_key"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_animation(movement):
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			if !is_attacking:
				animation.play('side_idle')
	
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			if !is_attacking:
				animation.play('side_idle')
	
	if direction == "down":
		animation.flip_h = false
		if movement == 1:
			animation.play("front_walk")
		elif movement == 0:
			if !is_attacking:
				animation.play('front_idle')
	
	if direction == "up":
		animation.flip_h = false
		if movement == 1:
			animation.play("back_walk")
		elif movement == 0:
			if !is_attacking:
				animation.play('back_idle')

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_range = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_range = false

func enemy_attack():
	if enemy_in_range and enemy_attack_cooldown:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print("player took %d damage" % 20)
		print("current health is %d" % health)
		
		if health <= 0:
				self.queue_free()

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func attack():
	var direction = current_direction
	
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		is_attacking = true
		
		if direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
			
		if direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			$deal_attack_timer.start()
			
		if direction == "down":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("front_attack")
			$deal_attack_timer.start()
			
		if direction == "up":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("back_attack")
			$deal_attack_timer.start()

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	global.player_current_attack = false
	is_attacking = false

func current_camera(): 
	if global.current_scene == "world":
		$world_camera.enabled = true
		$glade_camera.enabled = false
	elif global.current_scene == "glade":
		$world_camera.enabled = false
		$glade_camera.enabled = true
	elif global.current_scene == "nook":
		$world_camera.enabled = false
		$glade_camera.enabled = true
	elif global.current_scene == "farm":
		$world_camera.enabled = false
		$glade_camera.enabled = true





