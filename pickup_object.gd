extends RigidBody3D

func _ready() -> void:
	add_to_group("Pickup")
	
	# enable collision monitoring
	contact_monitor = true
	max_contacts_reported = 1
	body_entered.connect(on_bump)

func on_pickup():
	linear_damp = 10

func while_pickup(force: Vector3):
	pass

func off_pickup():
	linear_damp = 0

func on_bump(bumpee: Node3D):
	print(bumpee.name)

#mechanic is picking stuff up. when something bumps into something else, an
#interaction occurs. for example, a bag of 10 carrots seeds being placed onto
#an empty garden plot will plant 1 seed in the plot, removing it from the bag.
