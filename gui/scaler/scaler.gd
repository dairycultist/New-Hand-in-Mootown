extends Control

func _ready() -> void:
	GlobalGUI.connect_scaler(_on_gui_scale_changed)

func _on_gui_scale_changed(new_scale: float):
	pass
