extends Node

@onready var admob: Admob = $Admob


func _ready() -> void:
	admob.initialize()

# 広告の初期化完了時
func _on_admob_initialization_completed(status_data: InitializationStatus) -> void:
	pass # Replace with function body.
