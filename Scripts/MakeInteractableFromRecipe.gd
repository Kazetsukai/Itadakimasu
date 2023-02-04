extends Node


func _ready():
	trigger()

func trigger():
	var parent = get_parent()
	var siblings = parent.get_children(0)
	var recipe
	for n in siblings:
		if n is TextureRect:
			recipe = n
			break
	if recipe == null: return
	var children = recipe.get_children()
	for c in children:
		recipe.remove_child(c)
		parent.add_child.call_deferred(c)
		
	parent.texture = recipe.texture
	parent.item_type = recipe.item_type
	parent.tooltip_text = parent.item_type
	parent.remove_child.call_deferred(recipe)
	recipe.queue_free()
