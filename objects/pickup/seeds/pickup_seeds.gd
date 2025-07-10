extends "res://objects/pickup/pickup_object.gd"

var SOUND_BUY = preload("res://objects/pickup/seeds/buy.wav")

@export var crop: PackedScene
@export var seed_name: String = "Seeds"
@export var seed_count: int = 10

# might separate into a pickup_buyable later that this extends
@export var bought: bool = false
@export var money_cost: int = 10

func get_display_string() -> String:
	
	if bought:
		return str(seed_count) + " " + seed_name
	else:
		return str(seed_count) + " " + seed_name + " (¢" + str(money_cost) + ")"

func on_pickup():
	
	super.on_pickup()
	
	if not bought:
		GlobalSound.play(SOUND_BUY)
		bought = true

func on_bump(bumpee: Node3D):
	
	if bumpee.is_in_group("SeedPlot") and bumpee.get_child_count() == 2:
		
		var to_plant = crop.instantiate()
		bumpee.add_child(to_plant)
		to_plant.initialize_as_planted()
		
		seed_count -= 1
	
	if seed_count <= 0:
		queue_free()
