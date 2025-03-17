extends Node3D

@export var tscn_path := "res://rigidbodies/chip.tscn"
@export var spacing := 1

func _ready() -> void:
	
	var tscn := load(tscn_path)
	
	for x in 4:
		for z in 4:
			var child = tscn.instantiate()
			add_child(child)
			
			child.global_position = global_position + Vector3(x, 0, z)
