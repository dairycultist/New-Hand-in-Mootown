extends CharacterBody3D

#what if, during the day you collect shapes to bring them back to your base where you can put them in a big glass tube, once they're in the tube you can use them to buy items which you need for night. at night, enemies try to attack and break your glass tube
#you can get weapons, movement upgrades, and maybe even build structures to help u
#what if it's like, magic themed
#use the crystals to cast spells

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

var camera_pitch := 0.0
var held : RigidBody3D
var looking_holdable : RigidBody3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	crosshair.material.set("shader_parameter/size", 0.02)

func _process(delta: float) -> void:
	
	var ray_result = get_world_3d().direct_space_state.intersect_ray(
		PhysicsRayQueryParameters3D.create(camera.global_position, hold_anchor.global_position)
	)
	
	if ray_result.has("collider") and ray_result.collider is RigidBody3D:
		looking_holdable = ray_result.collider
	else:
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
		held.apply_central_force((hold_anchor.global_position - held.global_position) * 100)
	
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
		
		if looking_holdable:
			held = looking_holdable
			held.linear_damp = 10
			
			if "can_float" in held:
				held.can_float = false
	
	if (event.is_action_released("interact")):
		
		if held:
			if "can_float" in held:
				held.can_float = true
			
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
