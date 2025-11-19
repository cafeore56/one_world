extends Node2D
class_name Opening

@onready var start_button: Button = $StartButton


func _ready() -> void:
	start_button.pressed.connect(func() -> void:
		SceneManager.change_scene("main"))
