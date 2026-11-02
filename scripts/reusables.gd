extends Node

func load_json_file(file):
	var file2 := FileAccess.open(file, FileAccess.READ)
	
	if file2 == null:
		push_error("idfk the json file is null")
		return null
	
	var json := JSON.new()
	var error := json.parse(file2.get_as_text())
	
	if error != OK:
		push_error("sum bs json error at %d: %s" % [
			json.get_error_line(),
			json.get_error_message()
		])
		return
	
	return json.data
