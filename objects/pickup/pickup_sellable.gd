extends "res://objects/pickup/pickup_object.gd"

var SOUND_SELL = preload("res://objects/pickup/crop/sell_crop.wav")

@export var money_worth: int = 1

func on_bump(bumpee: Node3D):
	
	super.on_bump(bumpee)
	
	if bumpee.is_in_group("SellRegion"):
		
		GlobalSound.play(SOUND_SELL)
		GlobalData.attempt_change_money_by(money_worth)
		queue_free()
