extends Control

@export var health_changed_label: PackedScene


func _ready() -> void:
	SignalBus.on_health_changed.connect(on_signal_health_changed)


func on_signal_health_changed(node: Node, amount_changed: int):
	var label_instance = health_changed_label.instantiate()
	node.add_child(label_instance)
	label_instance.text = str(amount_changed)
