extends Control

var starting_inventory = [
	"RiceSeedlings",
	"WasabiSeed",
	"FishingRod",
	"SugarBeetSeed",
	"Salt",
	"Vinegar",
	"Knife",
	"Grater",
	"Water"
]

var item_list = {
	"SalmonSushi": preload("res://Items/SalmonSushi.tscn"),
	
	"SeasonedSushiRice": preload("res://Items/SeasonedSushiRice.tscn"),
	"Salt": preload("res://Items/Salt.tscn"),
	"Sugar": preload("res://Items/Sugar.tscn"),
	"Vinegar": preload("res://Items/Vinegar.tscn"),
	"Water": preload("res://Items/Water.tscn"),
	
	"SteamedWhiteRice": preload("res://Items/SteamedWhiteRice.tscn"),
	"WhiteRiceUncooked": preload("res://Items/WhiteRiceUncooked.tscn"),
	"BrownRice": preload("res://Items/BrownRice.tscn"),
	"ThreshedRice": preload("res://Items/ThreshedRice.tscn"),
	"RicePlants": preload("res://Items/RicePlants.tscn"),
	"RiceSeedlings": preload("res://Items/RiceSeedlings.tscn"),

	"SalmonSashimi": preload("res://Items/RecipeItem.tscn"),
	"SalmonBlock": preload("res://Items/RecipeItem.tscn"),
	"Salmon": preload("res://Items/RecipeItem.tscn"),

	"Knife": preload("res://Items/RecipeItem.tscn"),
	"FishingRod": preload("res://Items/RecipeItem.tscn"),
	"Grater": preload("res://Items/Grater.tscn"),
	"RiceCooker": preload("res://Items/RiceCooker.tscn"),
	
	"River": preload("res://Items/RecipeItem.tscn"),
	"Field": preload("res://Items/Field.tscn"),
	"RiceField": preload("res://Items/RiceField.tscn"),
	
	"Husker": preload("res://Items/Husker.tscn"),
	"Thresher": preload("res://Items/Thresher.tscn"),
	"Evaporator": preload("res://Items/Evaporator.tscn"),
	"BranRemover": preload("res://Items/BranRemover.tscn"),
	
	"SugarBeetSeed": preload("res://Items/SugarBeetSeed.tscn"),
	"SugarBeet": preload("res://Items/SugarBeet.tscn"),
	"SugarBeetJuice": preload("res://Items/SugarBeetJuice.tscn"),
	
	"WasabiSeed": preload("res://Items/RecipeItem.tscn"),
	"WasabiPlant": preload("res://Items/RecipeItem.tscn"),
	"WasabiPaste": preload("res://Items/WasabiPaste.tscn"),
}

var recipes = {
	"SalmonSushi": ["SeasonedSushiRice", "WasabiPaste", "SalmonSashimi"],
	
	"SeasonedSushiRice": ["SteamedWhiteRice", "Salt", "Sugar", "Vinegar"],
	"SteamedWhiteRice": ["Water", "WhiteRiceUncooked", "RiceCooker"],
	"WhiteRiceUncooked": ["BrownRice", "BranRemover"],
	"BrownRice": ["Husker", "ThreshedRice"],
	"ThreshedRice": ["Thresher", "RicePlants"],
	"RicePlants": ["RiceSeedlings", "RiceField"],
	
	"WasabiPaste": ["WasabiPlant", "Grater"],
	"WasabiPlant": ["WasabiSeed", "River"],
	
	"SalmonSashimi": ["SalmonBlock", "Knife"],
	"SalmonBlock": ["Salmon", "Knife"],
	"Salmon": ["River", "FishingRod"],
	
	"SugarBeet": ["Field", "SugarBeetSeed"],
	"SugarBeetJuice": ["SugarBeet", "Crusher"],
	"Sugar": ["SugarBeetJuice", "Evaporator"]
}

var altRecipes = {
	"RicePlants": ["RiceSeedlings", "RiceField", "Water"],
}

var pickupable = preload("res://Interactables/PickupableFromRecipeItem.tscn")
var interactable = preload("res://Interactables/InteractableFromRecipeItem.tscn")

@onready var resultBox = $"../Result"
@onready var equals = $"../Equals"
@onready var recipePanel = $"../RecipePanel"
@onready var inventory = $"../InventoryBag/PanelContainer/ScrollContainer/ItemList"


func update_recipe():
	for c in resultBox.get_children():
		resultBox.call_deferred("remove_child", c)
		c.queue_free()
	
	var items = get_children()
	visible = len(items) > 0
	resultBox.visible = visible
	equals.visible = visible
	recipePanel.visible = visible
	
	var foundRecipe
	for recipeName in recipes:
		var recipe = recipes[recipeName]
		var foundAll = true
		if len(recipe) != len(items):
			continue
		for item in items:
			if !recipe.has(item.item_type):
				foundAll = false
				break
		if foundAll:
			foundRecipe = recipeName
			break
	
	for recipeName in altRecipes:
		var recipe = altRecipes[recipeName]
		var foundAll = true
		if len(recipe) != len(items):
			continue
		for item in items:
			if !recipe.has(item.item_type):
				foundAll = false
				break
		if foundAll:
			foundRecipe = recipeName
			break
	
	if foundRecipe:
		var item = make_item(foundRecipe)
		var pick = pickupable.instantiate()
		pick.add_child(item)
		resultBox.add_child(pick)

func clear_recipe():
	var items = get_children()
	for n in items:
		n.queue_free()
		remove_child(n)

func remove_item(item):
	remove_child(item)
	item.queue_free()
	update_recipe()

func add_item(item_name):
	if recipe_already_has(item_name):
		return
	var item = make_item(item_name)
	add_child(item)
	$"../InventoryBag".hide_inventory()
	update_recipe()

func add_item_to_inventory(item_name, animate = false):
	if !inventory_already_has(item_name):
		var item = make_item(item_name)
		var interac = interactable.instantiate()
		interac.add_child(item)
		inventory.add_child(interac)
		if animate:
			$"../InventoryBag".show_inventory()
			var fader = preload("res://Fader.tscn").instantiate()
			var sparkle = preload("res://ItemSparkle.tscn").instantiate()
			fader.target = interac
			get_parent().add_child(fader)
			interac.add_child(sparkle)
			sparkle.position = (interac as Control).size / 2
	clear_recipe()
	update_recipe()

func recipe_already_has(item_name):
	for n in get_children():
		if n.item_type == item_name:
			return true
	return false

func inventory_already_has(item_name):
	for n in inventory.get_children():
		if n.item_type == item_name:
			return true
	return false

func make_item(item_name):
	var prefab = preload("res://Items/RecipeItem.tscn")
	var found = false
	if item_list.has(item_name):
		prefab = item_list[item_name]
		found = true
	var item = prefab.instantiate()
	item.item_type = item_name
	item.tooltip_text = item_name

	#if !found:
	var text = Label.new()
	text.text = item_name
	text.position.y -= 16
	item.add_child(text)

	return item
