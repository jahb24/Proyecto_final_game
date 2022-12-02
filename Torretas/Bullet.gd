extends RigidBody2D

var velocity = 0
var speed = 0.2

func _physics_process(delta):
	position.y += velocity

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func sound():
	$songshot.play()


func _on_Bullet_body_entered(body):
	queue_free()
	pass # Replace with function body.
