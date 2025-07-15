extends Node

signal _gui_scale_changed(new_scale: float)

func _ready() -> void:

	get_tree().get_root().size_changed.connect(_on_size_changed)

func connect_scaler(on_gui_scale_changed: Callable):
	
	_gui_scale_changed.connect(on_gui_scale_changed)
	_on_size_changed()

func _on_size_changed() -> void:
	
	_gui_scale_changed.emit(get_viewport().size.x / 4000.0 + 0.3)
