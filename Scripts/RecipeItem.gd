extends Control

@export var item_type : String


func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"/root/Global/UI/RecipeBox".remove_item(self)
