extends Node3D

@export var ITEM: PackedScene

func _process(delta: float) -> void:
	
	if get_child_count() == 0:
		
		var inst_item = ITEM.instantiate()
		add_child(inst_item)
		inst_item.position.y = -1
		
	else:
		
		if get_child(0).position.y < 0:
			get_child(0).position.y += delta

#var SOUND_BUY = preload("res://pickup/buyable/buy.wav")
#@export var bought: bool = false
#@export var money_cost: int = 10
#
#func _ready() -> void:
	#
	#super._ready()
	#freeze = true
#
#func get_display_string() -> String:
	#
	#if bought:
		#return super.get_display_string()
	#else:
		#return super.get_display_string() + "\nCosts ¢" + str(money_cost)
#
#func on_pickup():
	#
	#super.on_pickup()
	#
	#if not bought and GlobalData.attempt_change_money_by(-money_cost):
		#
		#GlobalSound.play(SOUND_BUY)
		#freeze = false
		#bought = true
		#reparent(get_tree().root)
