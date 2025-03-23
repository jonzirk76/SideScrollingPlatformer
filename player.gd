extends CharacterBody2D

signal character_state(current_state)
signal spawn_platform(position)
signal spawn_wall(wall_position)
signal Transitioned

@onready var state_machine = $StateMachine
@onready var animation_player = $AnimationPlayer

func _process(delta: float) -> void:
	if velocity.x < 0:
		$Sprite2D.flip_h = true
		$WallPoint.position.x = -16
		if state_machine.current_state is OnWall:
			$Sprite2D.flip_h = false
			$WallPoint.position.x = 16
	elif velocity.x > 0:
		$Sprite2D.flip_h = false
		$WallPoint.position.x = 16
		if state_machine.current_state is OnWall:
			$Sprite2D.flip_h = true
			$WallPoint.position.x = -16
		
	if state_machine.current_state is Standing:
		animation_player.speed_scale = .8
		animation_player.play("Standing")
	elif state_machine.current_state is MovingOnGround:
		animation_player.speed_scale = 2
		animation_player.play("Running")
		
	if state_machine.current_state is InAir:
		if velocity.y > 0:
			animation_player.speed_scale = 2
			animation_player.play("Falling")
		elif velocity.y < 0 and velocity.y > -300:
			animation_player.speed_scale = 2
			animation_player.play("Flip")
		elif velocity.y < -300:
			animation_player.speed_scale = 2
			animation_player.play("Jump")
			
	if state_machine.current_state is OnWall:
		animation_player.play("OnWall")
	
	if state_machine.current_state is MakeWall:
		animation_player.speed_scale = 3
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func state_changed(current_state: Variant) -> void:
	character_state.emit(current_state)


func _on_in_air_spawn_platform(position: Variant) -> void:
	spawn_platform.emit(position)

func _on_make_wall_make_wall() -> void:
	spawn_wall.emit($WallPoint.global_position)
