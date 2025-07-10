extends Node

var source: AudioStreamPlayer3D

func _ready() -> void:
	
	source = AudioStreamPlayer3D.new()
	get_node("/root/World").add_child(source)

func play(sound: AudioStreamWAV):
	
	source.stream = sound
	source.play()
