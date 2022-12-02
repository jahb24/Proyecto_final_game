extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property($Fires, 'rect_scale', Vector2(0.5,0.5), Vector2(1.25,1.25), 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.interpolate_property($Fires, 'modulate:a', \
		1,0,0.35,Tween.TRANS_QUAD,Tween.EASE_OUT)
	#pass # Replace with function body.
	$Tween.start()




# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_all_completed():
	queue_free()
	pass # Replace with function body.
