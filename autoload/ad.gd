extends Node

@onready var admob: Admob = $Admob

var is_initialize: bool = false


func _ready() -> void:
	admob.initialize()


# 広告の初期化完了時
func _on_admob_initialization_completed(status_data: InitializationStatus) -> void:
	is_initialize = true
	
	if !Globals.ad:
		print("おふ")
		return
	else :
		# 画面下の広告を出す
		if is_initialize:
			admob.load_banner_ad()
			await admob.banner_ad_loaded
			admob.show_banner_ad()
			print("おん")
