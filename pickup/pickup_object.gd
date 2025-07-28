extends RigidBody3D

@export var DEFAULT_DISPLAY_STRING: String = "UNUSED"
@export var SOUND_BUMP: AudioStreamWAV

var time_of_last_bump_sound := 0

func _ready() -> void:
	
	# label this object so the player knows it can be picked up
	add_to_group("Pickup")
	
	# enable collision monitoring
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(on_bump)

# used either when holding or, if not holding, looking
func get_display_string() -> String:
	return DEFAULT_DISPLAY_STRING

func on_pickup():
	linear_damp = 10

func while_pickup(_force: Vector3):
	pass

func off_pickup():
	linear_damp = 0

func on_bump(bumpee: Node3D):
	
	# tell the bumpee it has been bumped
	if bumpee.has_method("on_bumped_by_pickup"):
		
		bumpee.on_bumped_by_pickup(self)
	
	# bump sound
	if SOUND_BUMP and Time.get_ticks_msec() - time_of_last_bump_sound > 300:
		
		time_of_last_bump_sound = Time.get_ticks_msec()
		
		# map to [0,1]
		var volume := 1.0 - 1.0 / (linear_velocity.length() * 0.1 + 1.0)
		
		GlobalSound.play_param(SOUND_BUMP, volume, volume / 10 + 0.9, position)
