extends RigidBody2D
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal plane_quit
signal plane_crash
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func quit_signal():
	emit_signal("plane_quit")
	queue_free()

func _on_exit_screen_screen_exited():
	quit_signal()

func explosion():
	$explo.play()

func _on_Enemigo_body_entered(body):
	#explosion()
	$explo.play()
	$Tween.interpolate_property($Explosion, "scale", Vector2(0,0), Vector2(2,2), 0.5, Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	#$Explosion.show()
	$Plane.hide()
	$shadow.hide()
	emit_signal("plane_crash", body.name)
	yield(get_tree().create_timer(0.2), "timeout")
	quit_signal()
	
	pass # Replace with function body.
