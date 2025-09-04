extends CharacterBody2D

@export var speed: float = 3.0
var forward = Vector2(1,1).normalized()
const paddle_width: float = 100.0
var is_running: bool = false

func _physics_process(delta: float) -> void:
	if (not is_running):
		if (Input.is_action_just_pressed("Start")):
			is_running = true
			visible = true
			
		return
	
	var collision: KinematicCollision2D = move_and_collide(forward * speed)
	if (collision):
		forward = forward.bounce(collision.get_normal())
		speed = clamp(speed + 0.2, 2, 10)
			
		if (collision.get_collider().is_in_group("Paddle")):
			var paddle_x = collision.get_collider().position.x - paddle_width /2
			var pos_on_paddle = (position.x - paddle_x) / paddle_width
			print("Hit the Paddle!")
			var bounce_angle = lerp(-PI * 0.8, -PI * 0.2, pos_on_paddle)
			forward = Vector2.from_angle(bounce_angle)
			
		if (collision.get_collider().is_in_group("GameOver")):
			is_running = false
