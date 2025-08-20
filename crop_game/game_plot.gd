extends StaticBody3D

var VISUAL_PLOT = preload("res://crop_game/visual_plot/plot.tscn")

# on minigame start, the plot gets fenced off and you must start planting FPS style

# you plant one seed at a time (which seed type it is is random and shown in the
# center), if there are no more possible moves, it goes
# FINISH! even if the timer isn't up yet. you need to make 3-or-more-in-a-rows to
# clear the planted seeds and get the crop from them. at the end you are given a
# bags of each crop you grew that you can sell.

# difficulty comes from 1) unique plot arrangements (use String parsing like
# Minecraft recipes for this) and 2) unique crop mechanics (local to the area).
# you can buy items from the shop to use during Crop Game to make it easier.

var CARROT := preload("res://crop_game/visual_crops/carrot/carrot.tscn")
var TURNIP := preload("res://crop_game/visual_crops/turnip/turnip.tscn")
var SUGAR_CHERRY := preload("res://crop_game/visual_crops/sugar_cherry/sugar_cherry.tscn")

func _ready() -> void:
	
	for x in range(0, 4):
		for z in range(0, 4):
			
			var plot := VISUAL_PLOT.instantiate()
			add_child(plot)
			plot.position = Vector3(x * 2, 0, z * 2)

func on_poke(player: CharacterBody3D, poke_info: Dictionary):
	
	var crops = [CARROT, TURNIP, SUGAR_CHERRY]
	crops.shuffle()
	var crop = crops[0].instantiate()
	add_child(crop)
	crop.position = Vector3(
		floor((poke_info.position.x + 1) / 2) * 2,
		0.2,
		floor((poke_info.position.z + 1) / 2) * 2
	)
