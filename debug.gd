extends CanvasLayer

func _on_main_character_state_debug(current_state: Variant) -> void:
	$CharacterStateLabel.text = str(current_state)
