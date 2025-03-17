extends Node3D

const CHIP = preload("res://rigidbodies/chip.tscn")

func _ready() -> void:
	
	for x in 4:
		for y in 4:
			for z in 4:
				var chip := CHIP.instantiate()
				add_child(chip)
				
				chip.global_position = global_position + Vector3(x, y, z)
