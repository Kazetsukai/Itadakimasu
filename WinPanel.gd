extends Panel

func _ready():
	visible = false

func show_win():
	visible = true
	await get_tree().create_timer(1).timeout
	
	while true:
		await get_tree().create_timer(1.4 * randf()).timeout
		var sparkle = preload("res://ItemSparkle.tscn").instantiate()
		sparkle.position = get_viewport().get_visible_rect().size
		sparkle.position.x *= randf()
		sparkle.position.y *= randf()
		add_child(sparkle)
		

