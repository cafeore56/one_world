extends Node
## SaveLoader


var config = ConfigFile.new()
const FILE_PATH: String = "user://gamedata.cfg"


func _ready():
	if !FileAccess.file_exists(FILE_PATH):
		config.set_value("data", "gate_id", 0)
		
		config.save_encrypted_pass(FILE_PATH, "mai")
	else :
		config.load_encrypted_pass(FILE_PATH, "mai")



func save_game():
	config.set_value("data", "gate_id", Globals.gate_id)
	
	config.save_encrypted_pass(FILE_PATH, "mai")


func load_game():
	for section in config.get_sections():
		for key in config.get_section_keys(section):
			if key == "gate_id":
				Globals.gate_id = config.get_value(section, key)


#func save_player(key: String, value):
	#config.set_value("player", key, value)
	#config.save_encrypted_pass(FILE_PATH, "mai")
#
#func load_player():
	#var dic = {}
	#for key in config.get_section_keys("player"):
		#dic[key] = config.get_value("player", key)
	#
	#return dic


func all_reset():
		Globals.gate_id = 0
