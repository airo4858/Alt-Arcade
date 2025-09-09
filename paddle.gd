extends CharacterBody2D

func _physics_process(delta: float) -> void:
	position.x = clamp(position.x,0,432)
	if (Input.is_action_pressed("Left_1")):
		position.x -= 4
	if (Input.is_action_pressed("Left_2")):
		position.x -= 3
	if (Input.is_action_pressed("Left_3")):
		position.x -= 2
	if (Input.is_action_pressed("Left_4")):
		position.x -= 1
	if (Input.is_action_pressed("Right_5")):
		position.x += 1
	if (Input.is_action_pressed("Right_6")):
		position.x += 2
	if (Input.is_action_pressed("Right_7")):
		position.x += 3
	if (Input.is_action_pressed("Right_8")):
		position.x += 4
