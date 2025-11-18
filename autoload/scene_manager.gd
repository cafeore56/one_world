extends CanvasLayer
## SceneManager

## onreadys.
## ----------------------------------------------
@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var yes_no_button_box: Control = $YesNoButtonBox
@onready var yes_button: Button = $YesNoButtonBox/HBoxContainer/YesButton
@onready var no_button: Button = $YesNoButtonBox/HBoxContainer/NoButton

## consts.
## ----------------------------------------------
# シーンパス
const SCENE_PATH := "res://scenes/%s.tscn"

## vars.
## ----------------------------------------------
# 遷移先のシーンパス（文字列URL）
var next_scene: String

## functions.
## ----------------------------------------------
func _ready() -> void:
	color_rect.hide()
	#yes_no_button_box.hide()
	
	yes_button.pressed.connect(func(): change_scene(next_scene))
	no_button.pressed.connect(func(): yes_no_button_box.hide())


# Path遷移
func change_scene(path: String) -> void:
	if not path:	# 引数が無ければ早期リターン
		return
	
	var scene = SCENE_PATH % path
	color_rect.visible = true
	animation_player.play("fade_to_black")
	await animation_player.animation_finished
	animation_player.play_backwards("fade_to_black")
	get_tree().change_scene_to_file(scene)
	await animation_player.animation_finished
	color_rect.visible = false
