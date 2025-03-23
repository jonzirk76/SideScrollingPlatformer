extends State

class_name OnWall

@export var wall_cling_speed = 100
@export var player: CharacterBody2D
@export var horizontal_speed := 300
@export var jump_velocity := -400

func Enter():
	player.velocity.y = wall_cling_speed
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta:float):
	player.velocity.y += wall_cling_speed * _delta
	
	if Input.is_action_just_pressed("make_wall"):
		Transitioned.emit(self, "makewall")
	
	var direction := Input.get_axis("left", "right")
	if direction and player.is_on_floor() == false:
		player.velocity.x = direction * horizontal_speed
		if player.is_on_wall() == true:
			pass
		else:
			Transitioned.emit(self,"inair")
	elif player.is_on_floor() == true:
		Transitioned.emit(self,"standing")
		
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_velocity
		player.velocity.x = horizontal_speed * player.get_wall_normal().x
		print(str(player.velocity.x))
		Transitioned.emit(self,"inair")
