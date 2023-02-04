extends TextureRect

@export var item_type : String

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"/root/Global/UI/RecipeBox".add_item(item_type)
