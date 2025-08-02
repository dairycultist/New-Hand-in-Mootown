extends StaticBody3D

# info on what their requested item is and fullness status is displayed on hover

# types of dialogue moomoos provide
# 1. introductionary dialogue that enables your ability to give them requested items
# 2. brief "I don't have any more dialogue right now" dialogue
# 3. randomized dialogue that changes every once in a while
# 4. conclusion dialogue thanking you for giving them the requested items
#    (followed by spawning your reward)

@export var can_sell_to: bool

func get_display_string() -> String:
	return "Jess"

func on_poke(player: CharacterBody3D):
	player.start_dialogue("res://moomoos/test_dialogue.txt")

func on_bumped_by_pickup(pickup: Node3D):
	
	if can_sell_to and pickup.has_method("sell"):
		
		pickup.sell()
	
	# when you give a shopkeep moo moo an item they requested, they both give you
	# money as if you're selling it, AND increase their fullness

# implement sprite rotation for wandering moo moos
