extends Control

var toggled_off : bool = false

func _on_button_pressed() -> void:
	if toggled_off:
		$CanvasLayer/TextureRect.show()
		$CanvasLayer/TextureRect2.hide()
		$AudioStreamPlayer.stream_paused = false
		toggled_off = false
		
	else:
		$CanvasLayer/TextureRect.hide()
		$CanvasLayer/TextureRect2.show()
		$AudioStreamPlayer.stream_paused = true
		toggled_off = true

func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.playing = true
