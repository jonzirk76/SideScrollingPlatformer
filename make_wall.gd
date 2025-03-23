extends State

class_name MakeWall

signal make_wall

@export var player: CharacterBody2D

func Enter():
	player.velocity = Vector2.ZERO
	player.animation_player.play("MakeWall")
	await player.animation_player.animation_finished
	make_wall.emit()
	if player.is_on_floor():
		Transitioned.emit(self,"standing")
	elif player.is_on_wall():
		Transitioned.emit(self,"onwall")
	else:
		Transitioned.emit(self,"inair")
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta:float):
	pass
