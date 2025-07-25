extends Node3D

@export var ITEM: PackedScene

func _process(delta: float) -> void:
	
	if get_child_count() == 0:
		
		var inst_item = ITEM.instantiate()
		add_child(inst_item)
		inst_item.position.y = -1
		
	else:
		
		if get_child(0).position.y < 0:
			get_child(0).position.y += delta
