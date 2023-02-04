extends TextureRect

var item_type

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"/root/Global/UI/RecipeBox".add_item_to_inventory(item_type, true)
