extends Node

@export var spawned_platform : PackedScene
@export var spawned_wall : PackedScene

func _on_character_body_2d_spawn_platform(position: Variant) -> void:
	var platform_instance = spawned_platform.instantiate()
	position.y = position.y + 10
	platform_instance.position = position
	call_deferred("add_child",platform_instance)

func _on_character_body_2d_spawn_wall(wall_position: Variant) -> void:
	var wall_instance = spawned_wall.instantiate()
	wall_instance.position = wall_position
	call_deferred("add_child",wall_instance)
