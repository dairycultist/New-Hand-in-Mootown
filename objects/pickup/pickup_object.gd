extends RigidBody3D

@export var SOUND_BUMP: AudioStreamWAV

func _ready() -> void:
	
	# label this object so the player knows it can be picked up
	add_to_group("Pickup")
	
	# enable collision monitoring
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(on_bump)

# used either when holding or, if not holding, looking
func get_display_string() -> String:
	return ""

func on_pickup():
	linear_damp = 10

func while_pickup(_force: Vector3):
	pass

func off_pickup():
	linear_damp = 0

func on_bump(_bumpee: Node3D):
	
	if SOUND_BUMP:
		
		# map to [0,1]
		var volume := 1.0 - 1.0 / (linear_velocity.length() * 0.1 + 1.0)
		
		GlobalSound.play_param(SOUND_BUMP, volume, 1.0)
