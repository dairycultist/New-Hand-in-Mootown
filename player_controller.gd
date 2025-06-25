extends CharacterBody3D

var CARROT := preload("res://crop/carrot.tscn")
var DIRT_PATCH := preload("res://crop/dirt_patch.tscn")

@export_group("GUI")
@export var crosshair : CanvasItem

@export_group("Misc")
@export var hold_anchor : Node3D
@export var camera : Camera3D

@export_group("Movement")
@export var mouse_sensitivity := 0.3
@export var walk_speed := 5
@export var jump_speed := 7
@export var max_fall_speed := 32

# stores reference to physical item held in hand (hidden/shown on demand)
# they can also be thrown on the ground, but not dragged (trying to will pick them up)
# they are identified by their names! i.e. "Trowel" "CarrotSeeds" etc
var inventory: Array = [ null, null, null, null ]
var selected_inv_slot := 0

var camera_pitch := 0.0
var held : RigidBody3D

var looking_node : Node3D
var looking_position : Vector3
var looking_holdable : RigidBody3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	crosshair.material.set("shader_parameter/size", 0.02)

func _process(delta: float) -> void:
	
	var ray_result = get_world_3d().direct_space_state.intersect_ray(
		PhysicsRayQueryParameters3D.create(camera.global_position, hold_anchor.global_position)
	)
	
	if ray_result.has("collider"):
		
		looking_node = ray_result.collider
		looking_position = ray_result.position
		
		if ray_result.collider is RigidBody3D:
			looking_holdable = ray_result.collider
		else:
			looking_holdable = null
			
	else:
		looking_node = null
		looking_holdable = null
	
	crosshair.material.set(
		"shader_parameter/size",
		lerpf(
			crosshair.material.get("shader_parameter/size"), 
			0.2 if held else 0.1 if looking_holdable else 0.02,
			delta * 15
		)
	)
	
	if held != null:
		# apply force that is the difference in position
		var force := (hold_anchor.global_position - held.global_position) * 100
		
		held.apply_central_force(force)
		
		if "crop_process_force" in held:
			held.crop_process_force(force)
	
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
		
		# picking stuff
		if looking_holdable:
			
			held = looking_holdable
			held.linear_damp = 10
		
		# depending on what we're holding, there may be
		# other actions we can perform, like planting or troweling
		elif looking_node and looking_node.name.contains("DirtPatch"):
			
			# destroy a dirt patch with the trowel
			looking_node.queue_free()
			
		elif looking_node:
			
			# place a dirt patch with the trowel
			var dirt_patch := DIRT_PATCH.instantiate()
			looking_node.add_child(dirt_patch)
			dirt_patch.global_position = looking_position + Vector3(0, 0.15, 0)
			dirt_patch.name = "DirtPatch"
			
		elif looking_node and looking_node.name.contains("DirtPatch") and looking_node.get_child_count() == 2:
			
			# plant a carrot on a dirt patch with a carrot seed bag
			var carrot := CARROT.instantiate()
			looking_node.add_child(carrot)
			carrot.position = Vector3.ZERO
	
	if (event.is_action_released("interact")):
		
		if held:
			held.linear_damp = 0
			held = null
	
	if event.is_action_pressed("pause"):
		
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if event is InputEventMouseMotion:
		
		rotation.y += deg_to_rad(-event.relative.x * mouse_sensitivity)
		
		camera_pitch = clampf(camera_pitch - event.relative.y * mouse_sensitivity, -90, 90)
		
		camera.rotation.x = deg_to_rad(camera_pitch)
