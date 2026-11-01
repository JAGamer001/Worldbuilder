extends Control

var category_path := "res://data/categories.json"
var tab_countainer: NodePath = "CategoriesList"
var category_scene: PackedScene = preload("res://prefabs/gui/editor_category.tscn")
var section_scene: PackedScene = preload("res://prefabs/gui/editor_section.tscn")

func _ready() -> void:
	category_setup()

func category_setup():
	var file := FileAccess.open(category_path, FileAccess.READ)
	
	var json := JSON.new()
	var error := json.parse(file.get_as_text())
	
	if error != OK:
		push_error("sum bs json error at %d: %s" % [
			json.get_error_line(),
			json.get_error_message()
		])
		return
	
	var categories = json.data
	var parent := get_node(tab_countainer)
	
	for category in categories:
		var tab := category_scene.instantiate()
		tab.name = str(category.get("name", "nullString"))
		
		var icon_file = "res://textures/" + category.get("icon", "")
		parent.add_child(tab)
		parent.set_tab_icon(parent.get_tab_count() - 1, load(icon_file))
		
		var sections = category.get("sections", [])
		
		for data in sections:
			var section := section_scene.instantiate()
			
			section.name = data
			tab.add_child(section)
			
			var section_label := section.get_node("Label")
			section_label.text = data
