extends CharacterBody3D

@export_group("Misc")
@export var hold_anchor : Node3D
@export var camera : Camera3D

@export_group("Movement")
@export var mouse_sensitivity := 0.3
@export var walk_speed := 5
@export var jump_speed := 7
@export var max_fall_speed := 32

var camera_pitch := 0.0
var held_pickup : RigidBody3D
var looking_pickup : RigidBody3D

func _ready() -> void:
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Crosshair.material.set("shader_parameter/size", 0.02)

func _process(delta: float) -> void:
	
	# if not holding a pickup, check if we're looking at a pickup
	if not held_pickup:
	
		var ray_result = get_world_3d().direct_space_state.intersect_ray(
			PhysicsRayQueryParameters3D.create(camera.global_position, hold_anchor.global_position)
		)
		
		if ray_result.has("collider") and ray_result.collider.is_in_group("Pickup"):
			looking_pickup = ray_result.collider
			set_display_text(looking_pickup.get_display_string())
		else:
			looking_pickup = null
			set_display_text("")
	
	else:
		
		# apply force that is the difference in position
		var force := (hold_anchor.global_position - held_pickup.global_position) * 100
		
		held_pickup.apply_central_force(force)
		held_pickup.while_pickup(force)
		
		# constantly update display text, since it can potentially change while holding
		set_display_text(held_pickup.get_display_string())
	
	$Crosshair.material.set(
		"shader_parameter/size",
		lerpf(
			$Crosshair.material.get("shader_parameter/size"), 
			0.2 if held_pickup else 0.1 if looking_pickup else 0.02,
			delta * 15
		)
	)
	
	# movement
	var input_dir := Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
	if (velocity.y > -max_fall_speed):
		velocity += get_gravity() * 2.5 * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_speed
	
	if direction:
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
	else:
		velocity.x = 0
		velocity.z = 0
		
	move_and_slide()


func _input(event):
	
	if (event.is_action_pressed("interact")):
		
		# picking up stuff
		if looking_pickup:
			held_pickup = looking_pickup
			held_pickup.on_pickup()
	
	if (event.is_action_released("interact")):
		
		# dropping stuff
		if held_pickup:
			held_pickup.off_pickup()
			held_pickup = null
			set_display_text("")
	
	if event.is_action_pressed("pause"):
		
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion:
		
		rotation.y += deg_to_rad(-event.relative.x * mouse_sensitivity)
		
		camera_pitch = clampf(camera_pitch - event.relative.y * mouse_sensitivity, -90, 90)
		
		camera.rotation.x = deg_to_rad(camera_pitch)

func set_display_text(text: String):
	
	if text == "":
		$DisplayText.visible = false
	else:
		$DisplayText.text = text
		$DisplayText.visible = true
