extends State

class_name InAir

signal spawn_platform(position)

@export var player: CharacterBody2D
@export var horizontal_speed := 300
@export var fall_speed := 800
@export var air_friction := 10
@export var starting_number_of_jumps := 1
@export var jump_velocity := -400

@onready var number_of_jumps := 0

func Enter():
	pass
	
func Exit():
	number_of_jumps = starting_number_of_jumps 

func Update(_delta: float):
	pass

func Physics_Update(_delta:float):
	player.velocity.y += fall_speed * _delta
	player.velocity.y = clamp(player.velocity.y, -812, 812)
	
	if Input.is_action_just_pressed("make_wall"):
		Transitioned.emit(self, "makewall")
	
	#Left/right movement
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x += 5 * direction * horizontal_speed * _delta
		player.velocity.x = clamp(player.velocity.x, horizontal_speed * -1, horizontal_speed)
		if player.is_on_floor() == true:
			Transitioned.emit(self,"movingonground")
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, air_friction)
		if player.is_on_floor() == true:
			Transitioned.emit(self,"standing")
			
	#Double Jump & Spawn Platform functionality
	if Input.is_action_just_pressed("jump") and number_of_jumps > 0:
		player.velocity.y = jump_velocity
		number_of_jumps -= 1
		if Input.is_action_pressed("make_platform"):
			spawn_platform.emit(player.position)
	
	#Gliding
	if Input.is_action_pressed("jump") and player.velocity.y > 0:
		player.velocity.y = 100
	
	if Input.is_action_just_released("jump") and player.velocity.y < 0:
		player.velocity.y = 0
		
	#Wall slide
	if player.is_on_wall() == true:
		Transitioned.emit(self, "onwall")
