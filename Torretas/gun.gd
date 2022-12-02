extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal shoot

var target = null
var can_shoot = true

var Bullet = preload("res://Bullet.tscn")
#var Fire = preload("res://Fire.tscn")

func flash():
	#var f = Fire
	#add_child(f.instance())
	$fires.show()
	yield(get_tree().create_timer(0.09), "timeout")
	$fires.hide()

func shoot():
	if can_shoot:
		can_shoot = false
		yield(get_tree().create_timer(0.05), "timeout")
		emit_signal("shoot", $puntero.global_transform)
		emit_signal("shoot", $puntero2.global_transform)
		flash()
		
		var bullet = Bullet.instance()
		var bullet2 = Bullet.instance()
		#bullet.position = $puntero.get("position"
		#print(can_shoot)
		var posPun = $puntero.get("position")
		var posPun2 = $puntero2.get("position")
		bullet.set_deferred("position", posPun)
		bullet.set_deferred("velocity", posPun.y * bullet.speed)

		#bullet.velocity = $puntero.get("position").y * bullet.speed
		#bullet.rotation = rotation_degrees
		#add_child(bullet)
		
		#bullet2.position = $puntero2.get("position")
		#bullet2.velocity = $puntero2.get("position").y * bullet.speed
		bullet2.set_deferred("position", posPun2)
		bullet2.set_deferred("velocity", posPun2.y * bullet2.speed)
		#bullet2.rotation = rotation_degrees
		#add_child(bullet2)
		
		call_deferred("add_child", bullet)
		call_deferred("add_child", bullet2)
		bullet.sound()
		can_shoot = true

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Tween.interpolate_property($fires, 'rect_scale', Vector2(0.5,0.5), Vector2(1.25,1.25), 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	pass # Replace with function body.

var tecla
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	"""
	if $Label.text == "0":
		if Input.is_action_pressed("ui_right"):
			rotation += 0.2
		elif Input.is_action_pressed("ui_left"):
			rotation -= 0.2
		elif Input.is_physical_key_pressed(48):
		#elif Input.is_action_pressed("ui_accept"):
			visible = 0
			shoot()
			visible = 1
	if $Label.text == "1":
		if Input.is_action_pressed("ui_right"):
			rotation += 0.2
		elif Input.is_action_pressed("ui_left"):
			rotation -= 0.2
		elif Input.is_physical_key_pressed(49):
			visible = 0
			shoot()
			visible = 1"""
	if Input.is_physical_key_pressed($Label.text.ord_at(0)):
		visible = 0
		shoot()
		visible = 1
	elif Input.is_physical_key_pressed($Label.text.ord_at(1)):
			if rotation_degrees > -90:
				rotation_degrees -= 6
	elif Input.is_physical_key_pressed($Label.text.ord_at(2)):
			if rotation_degrees < 90:
				rotation_degrees += 6
	
		#if Input.is_action_pressed("ui_right"):
		#	rotation += 0.2
		#elif Input.is_action_pressed("ui_left"):
		#	rotation -= 0.2
			
	
#	pass
