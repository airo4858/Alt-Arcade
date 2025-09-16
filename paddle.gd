extends CharacterBody2D

@export var movement: float = 0
@onready var scales_left = preload("res://scales_left.png")
@onready var scales_nuetral = preload("res://scales_nuetral.png")
@onready var scales_right = preload("res://scales_right.png")

func _physics_process(delta: float) -> void:
	position.x = clamp(position.x,48,384)
	position.x += movement
	if (Input.is_action_pressed("Left_1")):
		position.x -= 4
	if (Input.is_action_pressed("Left_2")):
		position.x -= 3
	if (Input.is_action_pressed("ui_left")):
		#position.x -= 2
		movement = -2
		get_parent().get_node("Scale").texture = scales_left
	if (Input.is_action_pressed("Left_4")):
		position.x -= 1
	if (Input.is_action_pressed("Right_5")):
		position.x += 1
	if (Input.is_action_pressed("ui_right")):
		#position.x += 2
		movement = 2
		get_parent().get_node("Scale").texture = scales_right
	if (Input.is_action_pressed("Right_7")):
		position.x += 3
	if (Input.is_action_pressed("Right_8")):
		position.x += 4
