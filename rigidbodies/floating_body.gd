extends RigidBody3D

var can_float := true

func _process(delta: float) -> void:
	
	# TODO should use AABB to determine if it's in the water, rather than origin
	# ... or just colliders, depends on where water's gonna be
	
	if can_float:
		if global_position.y < 0.5:
			apply_central_force(-get_gravity() * (1.0 - global_position.y) * mass)
			linear_damp = 0.5
			angular_damp = 0.5
		else:
			linear_damp = 0
			angular_damp = 0
