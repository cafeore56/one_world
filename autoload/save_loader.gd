extends Node
## SaveLoader


var config = ConfigFile.new()
const FILE_PATH: String = "user://gamedata.cfg"


func _ready():
	if !FileAccess.file_exists(FILE_PATH):	# データが無い場合は初期値を入力
		config.set_value("data", "gate_id", 0)
		
		config.save_encrypted_pass(FILE_PATH, "mai")
	else :
		config.load_encrypted_pass(FILE_PATH, "mai")



func save_game():
	config.set_value("data", "gate_id", Globals.gate_id)
	config.set_value("data", "money", Globals.money)
	config.set_value("data", "exp", Globals.exp)
	
	config.save_encrypted_pass(FILE_PATH, "mai")


func load_game():
	for section in config.get_sections():
		for key in config.get_section_keys(section):
			if key == "gate_id":
				Globals.gate_id = config.get_value(section, key)
			elif key == "money":
				Globals.money = config.get_value(section, key)
			elif key == "exp":
				Globals.exp = config.get_value(section, key)
