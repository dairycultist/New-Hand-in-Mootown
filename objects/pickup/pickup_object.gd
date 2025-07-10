extends RigidBody3D

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

func while_pickup(force: Vector3):
	pass

func off_pickup():
	linear_damp = 0

func on_bump(bumpee: Node3D):
	pass
