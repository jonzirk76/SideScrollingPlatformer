extends State

class_name Standing

@export var player: CharacterBody2D
@export var friction := 300
@export var jump_velocity := -400

func Enter():
	player.velocity.x = move_toward(player.velocity.x, 0, friction)
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta:float):
	player.velocity.x = move_toward(player.velocity.x, 0, friction)
	if Input.is_action_just_pressed("make_wall"):
		Transitioned.emit(self, "makewall")
	
	if Input.is_action_pressed("left") and Input.is_action_pressed("right"):
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = jump_velocity
			Transitioned.emit(self, "inair")
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		if Input.is_action_just_pressed("jump"):
			player.velocity.y = jump_velocity
			Transitioned.emit(self, "inair")
		else:
			Transitioned.emit(self, "movingonground")
	elif Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_velocity
		Transitioned.emit(self, "inair")
	elif player.is_on_floor() == false:
		Transitioned.emit(self, "inair")
