extends StaticBody3D

var SOUND_SELL = preload("res://pickup/crop/sell_crop.wav")

@export var can_sell_to: bool

#GlobalSound.play(SOUND_SELL)
#GlobalData.attempt_change_money_by(money_worth)
#queue_free()

# provides dialogue, info on what their requested item is, what they give once
# fully befriended, and friendship status

# give shopkeeps two "fronts" like in stardew valley if you interact in the bar,
# they sell, if You interact on the side of the bar, You talk to them
# gotta implement sprite rotation anyways
