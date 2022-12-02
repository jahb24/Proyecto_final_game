extends RigidBody2D


signal quit_gun
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Torreta_body_entered(body):
	emit_signal("quit_gun")
	queue_free()
	pass # Replace with function body.
