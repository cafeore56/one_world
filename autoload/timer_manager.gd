extends Node
## TimerManager

# 製造時間の経過ごとに発火（秒）
signal elapsed_time_shot(elapsed_time: String)
# 優遇時間の経過ごとに発火（time）
signal ad_elapsed_time_shot(ad_elapsed_time: String)
# 優遇時間の経過ごとに発火（rare）
signal ad_elapsed_rare_shot(ad_elapsed_rare: String)

## constants.
## ----------------------------------------------
const DEFAULT_CREATE_TIME = 3		# 完成までのデフォルト時間（秒）
const PREFERENTIAL_CREATE_TIME = 60		# 完成までの優遇有りの時間（秒）
const DEFAULT_AD_TIME = 30				# 優遇時間（時間）
const DEFAULT_AD_RARE_TIME = 20			# 優遇時間（レア）
const WAIT_TIMER_TIME = 20				# 放置時間（秒）

## class.
## ----------------------------------------------
class TimerState:
	var timer: Timer
	var is_active: bool = false
	var counter: int
	var default_count: int
	 
	func _init(default_value: int) -> void:
		counter = default_value
		default_count = default_value
		timer = Timer.new()
		timer.wait_time = 1.0

## vars.
## ----------------------------------------------
# 作りたいタイマーの数だけ宣言しておくと便利
var create_state: TimerState			# 製造時間
var ad_time_state: TimerState			# 優遇（秒）
var ad_rare_state: TimerState			# 優遇（レア）

## functions.
## ----------------------------------------------
func _ready() -> void:
	# 各種TimerStateインスタンス作成
	create_state = TimerState.new(DEFAULT_CREATE_TIME)
	ad_time_state = TimerState.new(DEFAULT_AD_TIME)
	ad_rare_state = TimerState.new(DEFAULT_AD_RARE_TIME)
	
	_setup_timer(create_state.timer, create_timer_timeout)
	_setup_timer(ad_time_state.timer, ad_time_timeout)
	_setup_timer(ad_rare_state.timer, ad_rare_timeout)
	
	# 製造カウントスタート
	EventBus.create_robo_start_shot.connect(create_start)
	# Adカウントスタート（時間）
	EventBus.ad_time_start_shot.connect(ad_time_preferential_start)
	# Adカウントスタート（レア）
	EventBus.ad_rare_start_shot.connect(ad_rare_preferential_start)


# 作ったTimerインスタンスを追加 & timeout時に実行される関数を指定
func _setup_timer(timer: Timer, timeout_callback: Callable) -> void:
	add_child(timer)
	timer.timeout.connect(timeout_callback)

## signal functions.
## ----------------------------------------------
#1 製造シグナルを受け取って実行される
func create_start() -> void:
	create_state.is_active = true
	# Ad優遇有り（60秒）Ad優遇無し（100秒）
	create_state.counter = PREFERENTIAL_CREATE_TIME if ad_time_state.is_active else DEFAULT_CREATE_TIME
	elapsed_time_shot.emit(str(create_state.counter))	# 時間表示
	create_state.timer.start()							# スタート

#2 1秒経過ごとにtimeoutが呼ばれる
func create_timer_timeout() -> void:
	if not create_state.is_active:
		return
	create_state.counter -= 1
	if create_state.counter <= 0:
		_reset_timer_state(create_state)
		elapsed_time_shot.emit("")
		EventBus.completed_robo_shot.emit()	# 完成通知
	else :	# まだ製造中なので経過時間を表示
		elapsed_time_shot.emit(str(create_state.counter))


#1 AdTime優遇スタート
func ad_time_preferential_start() -> void:
	ad_time_state.is_active = true
	ad_elapsed_time_shot.emit(str(ad_time_state.counter))
	ad_time_state.timer.start()

#2 リセット
func ad_time_timeout() -> void:
	if not ad_time_state.is_active:
		return
	ad_time_state.counter -= 1
	if ad_time_state.counter <= 0:
		_reset_timer_state(ad_time_state)
		ad_elapsed_time_shot.emit("")
		EventBus.ad_time_reset_shot.emit()
	else:
		ad_elapsed_time_shot.emit(str(ad_time_state.counter))


#1 AdRare優遇スタート
func ad_rare_preferential_start() -> void:
	ad_rare_state.is_active = true
	ad_elapsed_rare_shot.emit(str(ad_rare_state.counter))
	ad_rare_state.timer.start()

#2 リセット
func ad_rare_timeout() -> void:
	if not ad_rare_state.is_active:
		return
	ad_rare_state.counter -= 1
	if ad_rare_state.counter <= 0:
		_reset_timer_state(ad_rare_state)
		ad_elapsed_rare_shot.emit("")
		EventBus.ad_rare_reset_shot.emit()
	else:
		ad_elapsed_rare_shot.emit(str(ad_rare_state.counter))


# counterで設定した時間が終了したのでリセット処理
func _reset_timer_state(state: TimerState) -> void:
	# アクティブをfalseに
	state.is_active = false
	# タイマーを停止
	state.timer.stop()
	# 0になったカウンターを初期値に戻す
	state.counter = state.default_count
