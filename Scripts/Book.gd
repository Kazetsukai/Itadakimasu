extends TextureRect

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"BackingPanel".visible = !$"BackingPanel".visible
