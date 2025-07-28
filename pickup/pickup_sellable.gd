extends "res://pickup/pickup_object.gd"

var SOUND_SELL = preload("res://pickup/crop/sell_crop.wav")

@export var money_worth: int = 1

# called on collision with moo moos
func sell() -> void:
	
	GlobalSound.play(SOUND_SELL)
	GlobalData.attempt_change_money_by(money_worth)
	queue_free()
