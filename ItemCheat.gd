extends GridContainer

var done = false

func _ready():
	for item_name in $"/root/Global/UI/RecipeBox".starting_inventory:
		$"/root/Global/UI/RecipeBox".add_item_to_inventory.call_deferred(item_name)

func _input(event):
	if event is InputEventKey:
		var e = (event as InputEventKey)
		if e.is_pressed() and e.keycode == 96:
			add_all_items()
		

func add_all_items():
	if !done:
		done = true
		for item_name in $"/root/Global/UI/RecipeBox".item_list:
			$"/root/Global/UI/RecipeBox".add_item_to_inventory(item_name, true)
