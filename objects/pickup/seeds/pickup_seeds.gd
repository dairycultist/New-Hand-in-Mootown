extends "res://objects/pickup/pickup_object.gd"

@export var crop: PackedScene
@export var seed_name: String = "Seeds"
@export var seed_count: int = 10

func get_display_string() -> String:
	return str(seed_count) + " " + seed_name

func on_bump(bumpee: Node3D):
	
	if bumpee.is_in_group("SeedPlot") and bumpee.get_child_count() == 2:
		
		var to_plant = crop.instantiate()
		bumpee.add_child(to_plant)
		to_plant.initialize_as_planted()
		
		seed_count -= 1
	
	if seed_count <= 0:
		queue_free()
