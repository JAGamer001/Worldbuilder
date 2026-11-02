extends Control

var toolbox: NodePath = "Toolbox"
var category_scene: PackedScene = preload("res://prefabs/gui/editor_category.tscn")
var section_scene: PackedScene = preload("res://prefabs/gui/editor_section.tscn")
var tool_scene: PackedScene = preload("res://prefabs/gui/editor_tool.tscn")

func _ready() -> void:
	category_setup()
	tool_setup()

func category_setup():
	var categories = Reusables.load_json_file("res://data/categories.json")
	var parent := get_node(toolbox)
	
	for category in categories:
		var node := category_scene.instantiate()
		var icon_file = "res://textures/" + category.get("icon", "")
		
		node.name = str(category.get("name", "nullString"))
		parent.add_child(node)
		parent.set_tab_icon(parent.get_tab_count() - 1, load(icon_file))
		
		var sections = category.get("sections", [])
		
		for data in sections:
			var section := section_scene.instantiate()
			
			section.name = data
			node.add_child(section)
			
			var section_label := section.get_node("Label")
			section_label.text = data

func tool_setup():
	var tools = Reusables.load_json_file("res://data/tools.json")
	var parent := get_node("Toolbar")
	
	for tool in tools:
		var node := tool_scene.instantiate()
		var icon_file = "res://textures/" + tool.get("icon", "")
		
		node.name = str(tool.get("name", "nullString"))
		node.icon = load(icon_file)
		parent.add_child(node)
