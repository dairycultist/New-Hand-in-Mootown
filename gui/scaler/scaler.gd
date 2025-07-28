extends Control

func _ready() -> void:
	GlobalGUI.connect_scaler(_on_gui_scale_changed)

func _on_gui_scale_changed(_new_scale: float):
	pass
