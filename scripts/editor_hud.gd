extends Control

@export var category_path := "res://data/categories.json"
@export var button_parent: NodePath
@export var button_scene: PackedScene

func _ready() -> void:
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

	var parent := get_node_or_null(button_parent)

	for category in categories:
		if not category is Dictionary:
			continue

		var button := button_scene.instantiate() as Button

		if button == null:
			continue

		button.text = str(category.get("name", "Unnamed"))
		
		var icon_file = "res://textures/" + category.get("icon", "")
		if ResourceLoader.exists(icon_file):
			button.icon = load(icon_file)

		parent.add_child(button)
