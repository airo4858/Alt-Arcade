extends CharacterBody2D

@export var opp_speed: float = 0.0

func _physics_process(delta: float) -> void:
	position.x = clamp(position.x,0,432)
	var ball_x = get_parent().get_node("Ball").position.x
	if (position.x == ball_x):
		opp_speed = 0
	if (position.x > ball_x):
		opp_speed = -0.7
	if (position.x < ball_x):
		opp_speed = 0.7
	position.x += opp_speed
