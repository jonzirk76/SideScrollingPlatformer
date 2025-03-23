extends Node2D

signal character_state_debug(current_state)

func _on_character_body_2d_character_state(current_state: Variant) -> void:
	character_state_debug.emit(current_state)
