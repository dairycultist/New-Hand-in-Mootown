extends Node

var _money: int = 0

func _ready() -> void:
	attempt_change_money_by(0)

func attempt_change_money_by(change: int) -> bool:
	
	if _money + change < 0:
		return false
	
	_money += change
	
	get_node("/root/World/MoneyDisplay").text = "¢" + str(_money)
	
	return true
