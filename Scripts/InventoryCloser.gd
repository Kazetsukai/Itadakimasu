extends Panel



func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"..".hide_inventory()
