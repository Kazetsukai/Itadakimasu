extends TextureRect



func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed and !$"../Book/BackingPanel".visible:
		toggle_inventory()

func toggle_inventory():
	$PanelContainer.visible = !$PanelContainer.visible
	$BackingPanel.visible = $PanelContainer.visible

func hide_inventory():
	$PanelContainer.visible = false
	$BackingPanel.visible = $PanelContainer.visible
	
func show_inventory():
	$PanelContainer.visible = true
	$BackingPanel.visible = $PanelContainer.visible
