extends CharacterBody2D

@export var speed: float = 1.0
var forward = Vector2(1,1).normalized()
const paddle_width: float = 100.0
var is_running: bool = false
var anubisscore: int = 0
var playerscore: int = 0

func _ready():
	$CollisionCooldown.start()

func reset_positions():
	position = get_parent().get_node("BallPosition").position
	forward = Vector2(1, 1).normalized()
	speed = 1.0
	visible = false
	get_parent().get_node("Paddle").position = get_parent().get_node("PaddlePosition").position
	get_parent().get_node("Opponent").position = get_parent().get_node("OpponentPosition").position
	get_parent().get_node("Opponent").opp_speed = 0

func _physics_process(delta: float) -> void:
	if (not is_running):
		visible = false
		get_parent().get_node("Paddle").position = Vector2(218,610)
		if (Input.is_action_just_pressed("Start")):
			is_running = true
			visible = true
			
		return
	
	var collision: KinematicCollision2D = move_and_collide(speed*forward)
	if collision and not $CollisionCooldown.is_stopped():
		return
	if (collision):
		$CollisionCooldown.start()
		forward = forward.bounce(collision.get_normal())
		speed = clamp(speed + 0.2, 1.1, 2.5)
			
		if (collision.get_collider().is_in_group("Paddle")):
			var paddle_x = collision.get_collider().position.x - paddle_width /2
			var pos_on_paddle = (position.x - paddle_x) / paddle_width
			var min_angle: float
			var max_angle: float
			if (collision.get_collider().is_in_group("Opponent")):
				min_angle = PI * 0.2 
				max_angle = PI * 0.8   
			else:
				min_angle = -PI * 0.8
				max_angle = -PI * 0.2
			var bounce_angle = lerp(min_angle,max_angle, pos_on_paddle)
			forward = Vector2.from_angle(bounce_angle)
			
		if (collision.get_collider().is_in_group("GameOver")):
			if (collision.get_collider().is_in_group("AnubisPoint")):
				anubisscore += 1
				get_parent().get_node("Scores/AnubisScore").text = str(anubisscore)
			if (collision.get_collider().is_in_group("PlayerPoint")):
				playerscore += 1
				get_parent().get_node("Scores/PlayerScore").text = str(playerscore)
			reset_positions()
			is_running = false
			
		if (anubisscore + 3 == playerscore):
			#haha you lose!
			await get_tree().create_timer(3).timeout
			get_tree().quit()
		if (playerscore + 3 == anubisscore):
			#haha you win!
			await get_tree().create_timer(3).timeout
			get_tree().quit()
