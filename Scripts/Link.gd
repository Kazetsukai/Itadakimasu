extends Control

@export var target: String

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene_to_file(target)
		$"/root/Global/UI/RecipeBox".update_recipe()
		$"/root/Global/UI/InventoryBag".hide_inventory()
