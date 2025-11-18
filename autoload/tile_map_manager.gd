class_name TileMapManager extends Node
## TileMapManager

static var _tile: TileMapLayer


## functions.
## ----------------------------------------------
func _ready() -> void:
	EventBus.tile_shot.connect(func(t): _tile = t)


# タイルの情報を取得(ローカル座標をタイルマップ座標にするVector2->Vector2i)
func get_tile_data_at(pos: Vector2) -> TileData:
	var local_position: Vector2i = _tile.local_to_map(pos)
	
	return _tile.get_cell_tile_data(local_position)


# 上の関数を使い取得したタイルのカスタムデータを調べる
func get_custom_data_at(pos: Vector2, custom_data_name: String) -> Variant:
	var data = get_tile_data_at(pos)
	if data:
		return data.get_custom_data(custom_data_name)
	else :
		return
