extends StaticBody3D

# when you give a shopkeep moo moo an item they requested, they both give you
# money as if you're selling it, AND increase their fullness
@export var can_sell_to: bool

func on_bumped_by_pickup(pickup: Node3D):
	
	if can_sell_to and pickup.has_method("sell"):
		
		pickup.sell()

# provides dialogue, info on what their requested item is, what they give once
# full, and fullness status

# implement sprite rotation for wandering moo moos
