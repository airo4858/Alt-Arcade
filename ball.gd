extends CharacterBody2D

@export var speed: float = 1.0
var forward = Vector2(1,1).normalized()
const paddle_width: float = 100.0
var is_running: bool = false

func _ready():
	$CollisionCooldown.start()

func _physics_process(delta: float) -> void:
	if (not is_running):
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
		speed = clamp(speed + 0.15, 1, 2.5)
			
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
			get_parent().get_node("Opponent").opp_speed = 0
			is_running = false
