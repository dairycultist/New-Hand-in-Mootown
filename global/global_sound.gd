extends Node

var sources: Array
var available_source_index: int = 0

var listener: Node3D # for position

func _ready() -> void:
	
	sources = [ AudioStreamPlayer3D.new(), AudioStreamPlayer3D.new(), AudioStreamPlayer3D.new() ]
	
	for source in sources:
		get_node("/root/World").add_child(source)
	
	listener = get_node("/root/World/Player")

func play(sound: AudioStreamWAV):
	
	play_param(sound, 1.0, 1.0, listener.global_position)

func play_param(sound: AudioStreamWAV, volume: float, pitch: float, position: Vector3):
	
	var source: AudioStreamPlayer3D = sources[available_source_index]
	available_source_index = (available_source_index + 1) % sources.size()
	
	source.stream = sound
	source.volume_linear = volume
	source.pitch_scale = pitch
	source.global_position = position
	source.play()
