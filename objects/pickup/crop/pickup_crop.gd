extends "res://objects/pickup/pickup_object.gd"

var SOUND_PLANT = preload("res://objects/pickup/crop/plant_crop.wav")
var SOUND_HARVEST = preload("res://objects/pickup/crop/harvest_crop.wav")
var SOUND_SELL = preload("res://objects/pickup/crop/sell_crop.wav")

@export var display_name: String = ""
@export var money_worth: int = 1

var growth := 0.0 # 0->1 is growing, then becomes -1 once fully grown
var seconds_to_fully_grown: int
var mat: Material

# also probably an "initialize_as_pickup"
func initialize_as_planted():
	
	GlobalSound.play(SOUND_PLANT)
	
	position = Vector3.ZERO
	
	var random := RandomNumberGenerator.new()
	
	rotation = Vector3(
		random.randf_range(-0.3, 0.3),
		random.randf_range(0.0, PI * 2.0),
		random.randf_range(-0.3, 0.3)
	)
	
	seconds_to_fully_grown = 5 # 60 * random.randi_range(3, 5)
	
	# duplicate the material so we can independently modify it
	mat = $Mesh.get_surface_override_material(0).duplicate()
	$Mesh.set_surface_override_material(0, mat)
	
	# disable the collider until fully grown
	$Collider.set_deferred("disabled", true)
	
	set_locked(true)

func _process(delta: float) -> void:
	
	if growth >= 0.0:
		
		growth += delta / seconds_to_fully_grown
		mat.set("shader_parameter/growth", min(1.0, growth));
		
		if growth >= 1.0:
			growth = -1.0
			$Collider.disabled = false

func get_locked():
	return axis_lock_linear_x

func set_locked(value: bool):
	
	axis_lock_linear_x = value
	axis_lock_linear_y = value
	axis_lock_linear_z = value
	axis_lock_angular_x = value
	axis_lock_angular_y = value
	axis_lock_angular_z = value

func get_display_string() -> String:
	return display_name

func while_pickup(force: Vector3):
	
	# wait until the object has a really high upward force on it before unfreezing
	if get_locked() and force.y > 120 and growth < 0.0:
		
		set_locked(false)
		position.y += 0.5 # move out a bit so we don't get stuck in the ground
		reparent(get_node("/root/World")) # un-parent from DirtPatch we're planted in
		GlobalSound.play(SOUND_HARVEST) # play a pop sound
		# spawn some dirt particles

func on_bump(bumpee: Node3D):
	
	if bumpee.is_in_group("SellBox"):
		
		GlobalSound.play(SOUND_SELL)
		GlobalData.attempt_change_money_by(money_worth)
		queue_free()
