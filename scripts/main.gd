extends Node2D
@onready var label: Label = $Label


func _ready() -> void:
	Globals.ad = true


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test.tscn")


func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test2.tscn")


func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_file("res://test/test3.tscn")
