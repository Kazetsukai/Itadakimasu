extends Node

@export var item_type: String

func _ready():
	var item = $"/root/Global/UI/RecipeBox".make_item(item_type)
	get_parent().add_child.call_deferred(item)
	get_parent().remove_child.call_deferred(self)
	get_parent().get_node("MakeInteractableFromRecipe").trigger.call_deferred()
