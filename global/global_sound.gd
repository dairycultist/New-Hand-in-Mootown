extends Node

var source: AudioStreamPlayer3D

func _ready() -> void:
	
	source = AudioStreamPlayer3D.new()
	get_node("/root/World").add_child(source)

func play(sound: AudioStreamWAV):
	
	source.stream = sound
	source.play()

func play_param(sound: AudioStreamWAV, volume: float, pitch: float):
	
	source.stream = sound
	source.volume_linear = volume
	source.pitch_scale = pitch
	source.play()
