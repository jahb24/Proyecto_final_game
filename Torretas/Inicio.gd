extends Node2D
"""
jamendo music para musica
En la parte de descripción en configuración se debe poner los datos de música,
imagenes, etc.
fotogramas png o sprites para la animación
the book of shaders
"""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var saludo = preload()

# Called when the node enters the scene tree for the first time.
func _ready():
	Score.visible = false
	$fade_sound.interpolate_property($music, "volume_db", 0, -70, 5, 1, Tween.EASE_IN_OUT)
	$roar.play()
	run.play("run")
	$timer.start()
	pass # Replace with function body.

func _on_visibilitynotifier2d_screen_entered():
	yield(get_tree().create_timer(0.75), "timeout")
	saludo.visible = true
	
func _on_visibilitynotifier2d_screen_excited():
	$fade_rays.start()
	$roar.stop()
	$music.play()
	saludo.visible = false

func _on_fade_rays_tween_completed():
	Score.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
