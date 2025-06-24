extends RigidBody3D

func _ready():
	
	var random := RandomNumberGenerator.new()
	
	global_rotation = Vector3(
		random.randf_range(-0.3, 0.3),
		random.randf_range(0.0, PI * 2.0),
		random.randf_range(-0.3, 0.3)
	)
	
	set_locked(true)

func get_locked():
	return axis_lock_linear_x

func set_locked(value: bool):
	
	axis_lock_linear_x = value
	axis_lock_linear_y = value
	axis_lock_linear_z = value
	axis_lock_angular_x = value
	axis_lock_angular_y = value
	axis_lock_angular_z = value

func crop_process_force(force: Vector3):
	
	# wait until the object has a really high upward force on it
	# before unfreezing
	if get_locked() and force.y > 120: # AND fully grown
		
		set_locked(false)
		position.y += 0.3
		# play a pop sound
