extends Node

var source: AudioStreamPlayer3D
var listener: Node3D

func _ready() -> void:
	
	source = AudioStreamPlayer3D.new()
	get_node("/root/World").add_child(source)
	listener = get_node("/root/World/Player")

func play(sound: AudioStreamWAV):
	
	source.stream = sound
	source.volume_linear = 1.0
	source.pitch_scale = 1.0
	source.global_position = listener.global_position
	source.play()

func play_param(sound: AudioStreamWAV, volume: float, pitch: float, position: Vector3):
	
	source.stream = sound
	source.volume_linear = volume
	source.pitch_scale = pitch
	source.global_position = position
	source.play()
