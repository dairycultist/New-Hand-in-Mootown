extends RigidBody3D

# wait until the object has a really high upward force on it
# before unfreezing

func _ready() -> void:
	
	# move down into ground, then do a random slight rotation
	
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

func crop_process_force(force: Vector3) -> void:
	
	if get_locked() and force.y > 120:
		set_locked(false)
		# play a pop sound
