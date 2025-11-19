extends Node2D
@onready var label: Label = $Label


func _ready() -> void:
	EventBus.testB.connect(func(): label.text = "変更だよ")

func _on_button_pressed() -> void:
	EventBus.testB.emit()
