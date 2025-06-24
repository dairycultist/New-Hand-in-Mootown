extends RigidBody3D

var growth := 0.0
var seconds_to_fully_grown : int
var mat : Material

func _ready():
	
	var random := RandomNumberGenerator.new()
	
	global_rotation = Vector3(
		random.randf_range(-0.3, 0.3),
		random.randf_range(0.0, PI * 2.0),
		random.randf_range(-0.3, 0.3)
	)
	
	seconds_to_fully_grown = random.randi_range(10, 100) # debug
	
	mat = $Mesh.get_surface_override_material(0).duplicate()
	$Mesh.set_surface_override_material(0, mat)
	
	set_locked(true)

func _process(delta: float) -> void:
	
	growth = min(1.0, growth + delta / seconds_to_fully_grown)
	
	mat.set("shader_parameter/growth", growth);

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
	if get_locked() and force.y > 120 and growth == 1.0:
		
		set_locked(false)
		position.y += 0.3
		# play a pop sound
