extends TextureRect

func _ready():
	$BookTutorial.play("BookGlow")

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		$"BackingPanel".visible = !$"BackingPanel".visible
		if $BookTutorial.is_playing():
			$BookTutorial.play("RESET")
