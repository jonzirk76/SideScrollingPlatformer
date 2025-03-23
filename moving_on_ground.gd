extends State

class_name MovingOnGround

@export var player: CharacterBody2D
@export var horizontal_speed := 300
@export var jump_velocity := -300

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta:float):
	if Input.is_action_just_pressed("make_wall"):
		Transitioned.emit(self, "makewall")
	
	#Horizontal Movement
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x += 5*direction * horizontal_speed * _delta
		player.velocity.x = clamp(player.velocity.x, horizontal_speed * -1, horizontal_speed)
	else:
		Transitioned.emit(self,"standing")
		
	#Air movement
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = jump_velocity
		Transitioned.emit(self, "inair")
	elif player.is_on_floor() == false:
		Transitioned.emit(self, "inair")
