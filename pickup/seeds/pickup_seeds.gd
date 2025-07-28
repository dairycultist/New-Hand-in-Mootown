extends "res://pickup/pickup_object.gd"

# TODO separate into a pickup_buyable later that this extends
var SOUND_BUY = preload("res://pickup/seeds/buy.wav")
@export var bought: bool = false
@export var money_cost: int = 10



@export var crop: PackedScene
@export var seed_name: String = "Seeds"
@export var seed_count: int = 10

func _ready() -> void:
	
	super._ready()
	freeze = true

func get_display_string() -> String:
	
	if bought:
		return str(seed_count) + " " + seed_name
	else:
		return str(seed_count) + " " + seed_name + "\nCosts ¢" + str(money_cost)

func on_pickup():
	
	super.on_pickup()
	
	if not bought and GlobalData.attempt_change_money_by(-money_cost):
		
		GlobalSound.play(SOUND_BUY)
		freeze = false
		bought = true
		reparent(get_tree().root)

func on_bump(bumpee: Node3D):
	
	super.on_bump(bumpee)
	
	if bumpee.is_in_group("SeedPlot") and bumpee.get_child_count() == 2:
		
		var to_plant = crop.instantiate()
		bumpee.add_child(to_plant)
		to_plant.initialize_as_planted()
		
		seed_count -= 1
	
	if seed_count <= 0:
		queue_free()
