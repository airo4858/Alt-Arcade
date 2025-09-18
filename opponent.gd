extends CharacterBody2D

@export var opp_speed: float = 0.0
@export var opp_movement: float = 0.7

func _physics_process(delta: float) -> void:
	position.x = clamp(position.x,0,432)
	opp_movement = clamp(opp_movement,0.7,0.8)
	var ball_x = get_parent().get_node("Ball").position.x
	if (position.x == ball_x):
		opp_speed = 0
	if (position.x > ball_x):
		opp_speed = -opp_movement
	if (position.x < ball_x):
		opp_speed = opp_movement
	position.x += opp_speed
