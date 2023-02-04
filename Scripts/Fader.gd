extends Node

var target
var alpha = 0


func _process(delta):
	if !target:
		finish()
		return
		
	if alpha < 1:
		alpha += delta
		target.modulate.a = alpha
	else:
		alpha = 1
		target.modulate.a = alpha
		finish()

func finish():
	queue_free()
