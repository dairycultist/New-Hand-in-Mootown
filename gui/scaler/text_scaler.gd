extends "res://gui/scaler/control_scaler.gd"

@export var _base_size: int = 52

func _ready() -> void:
	
	super._ready()
	theme = theme.duplicate()

func _on_gui_scale_changed(new_scale: float):
	
	super._on_gui_scale_changed(new_scale)
	theme.default_font_size = _base_size * new_scale
