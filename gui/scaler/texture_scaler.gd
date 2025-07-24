extends "res://gui/scaler/scaler.gd"

func _ready() -> void:
	
	super._ready()

func _on_gui_scale_changed(new_scale: float):
	
	super._on_gui_scale_changed(new_scale)
	
	scale = Vector2(new_scale, new_scale)
