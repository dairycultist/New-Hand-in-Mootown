extends RigidBody3D

var can_float := true

func _process(_delta: float) -> void:
	
	# use AABB to determine if it's in the water
	
	if can_float:
		
		for child in get_children():
			
			if child is VisualInstance3D:
				
				var y : float = global_position.y - child.get_aabb().size.y / 2
				
				if y < 0.0:
					apply_central_force(get_gravity() * (2 * y / child.get_aabb().size.y) * mass)
					linear_damp = 0.5
					angular_damp = 0.5
				else:
					linear_damp = 0
					angular_damp = 0
				
				break
