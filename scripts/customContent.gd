extends Node

var mod_folder_name = "Mods"
var resource_folder_name = "Resource Packs"
var maps_folder_name = "Maps"

func _ready():
	setup_folders()

func setup_folders():
	var dir = DirAccess.open("user://")
	
	if dir == null:
		push_error("hey where the fuck is the user data directory")
		return
	
	print("hey we found the user data directory")
	
	if not dir.dir_exists(mod_folder_name):
		print("no mods folder, making one now")
		dir.make_dir(mod_folder_name)
		
	if not dir.dir_exists(resource_folder_name):
		print("no resource packs folder, making one now")
		dir.make_dir(resource_folder_name)
	
	if not dir.dir_exists(maps_folder_name):
		print("no maps folder, making one now")
		dir.make_dir(maps_folder_name)
	
	print("ok all custom content folders exist now")
