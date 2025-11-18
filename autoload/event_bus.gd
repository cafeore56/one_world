extends Node
## EventBus


# Scene Change
signal change_scene_shot(path: String)
# Scene Switch
signal switch_scene_shot(path: String)

# ロボ製造（開始）
signal create_robo_start_shot
# ロボ製造可能（再セット）
signal create_robo_reset_shot
# ロボ完成
signal completed_robo_shot

# Ad開始（時間優遇）
signal ad_time_start_shot
# Ad再セット（時間優遇）
signal ad_time_reset_shot
# Ad開始（レア優遇）
signal ad_rare_start_shot
# Ad再セット（レア優遇）
signal ad_rare_reset_shot

# 広告
signal rewarded_display_shot		# 広告を表示させるだけ
signal rewarded_set_ok				# 広告がセットされた事を知らせる
signal rewarded_not_set				# 広告が用意できなかった
signal rewarded_shot				# 報酬
