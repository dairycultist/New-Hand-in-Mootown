extends MeshInstance3D

var SOUND_PLANT = preload("res://crop_game/plant_crop.wav")
var SOUND_HARVEST = preload("res://crop_game/harvest_crop.wav")

var growth := 0.0 # 0->1 is growing, then becomes -1 once fully grown
var mat: Material

#GlobalSound.play(SOUND_HARVEST) # play a pop sound
# spawn some dirt particles

func _ready() -> void:
	
	# duplicate the material so we can independently modify it
	mat = get_surface_override_material(0).duplicate()
	set_surface_override_material(0, mat)
	
	# plant
	GlobalSound.play(SOUND_PLANT)
	
	position = Vector3.ZERO
	
	var random := RandomNumberGenerator.new()
	
	rotation = Vector3(
		random.randf_range(-0.3, 0.3),
		random.randf_range(0.0, PI * 2.0),
		random.randf_range(-0.3, 0.3)
	)

func _process(delta: float) -> void:
	
	if growth >= 0.0:
		
		growth += delta
		mat.set("shader_parameter/growth", min(1.0, sqrt(growth)));
		
		if growth >= 1.0:
			growth = -1.0
