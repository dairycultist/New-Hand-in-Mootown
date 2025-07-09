extends "res://pickup/pickup_object.gd"

@export var crop: PackedScene
@export var seed_name: String = "Seeds"
@export var seed_count: int = 10

func get_display_string() -> String:
	return str(seed_count) + " " + seed_name

func on_bump(bumpee: Node3D):
	seed_count -= 1
