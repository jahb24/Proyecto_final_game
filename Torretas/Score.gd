#extends CanvasLayer
extends Node2D

#se precargan los niveles y se declaran variables importantes
var Nivel1 = preload("res://Nivel1.tscn")
var Nivel2 = preload("res://Nivel2.tscn")
var Nivel3 = preload("res://Nivel3.tscn")
#para guardar el score
var sco
#para guardar las instancias de los niveles
var n

# Called when the node enters the scene tree for the first time.
func _ready():
	new_level()
	
	#var a = ani.instance()
	#add_child(a)
	#a.get_node("mover").play("walk")

#para saber si el juego está pausado o no
var p = false
#para cambiar entre niveles
var lev = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#guarda los minutos restantes
	var minutos = int($Timer.get("time_left")/60)
	#guarda los segundos restantes
	var segundos = int($Timer.get("time_left"))%60
	#actualizan los datos de tiempo, score y nivel
	$HUD/Time.text = "Time: " + str(minutos) + ":" + str(segundos)
	$HUD/Score.text = "Score: " + sco.text
	$HUD/Level.text = "Level: " + str(lev)
	
	#si se llega a 100 puntos se muestra el menú para cambiar de nivel
	#si está en el último nivel, gana
	if int(sco.text) >= 100:
		if lev == 3:
			$Fondo3.visible = false
			$FondoWin.visible = true
			$win.visible = true
			get_tree().paused = true
		else:
			menu_change()

#muestra el menú de pausa
func show_menu():
	$Menu/VBox/Continue.disabled = true
	$Menu/VBox/GoBack.disabled = true
	$Menu.visible = !$Menu.visible
	$HUD.visible = !$HUD.visible
	$Mute.visible = !$Mute.visible
	
	get_tree().paused = !get_tree().paused
	
	#emit_signal("pause")

#muestra el menú de cambio de nivel
func menu_change():
	# si es el primer nivel, no se puede ir niveles atrás
	if lev == 1:
		$Menu/VBox/GoBack.disabled = true
	else:
		$Menu/VBox/GoBack.disabled = false
	#si es el nivel 3, no se puede ir niveles adelante
	if lev == 3:
		$Menu/VBox/Continue.disabled = true
	else:
		$Menu/VBox/Continue.disabled = false
	get_tree().paused = true
	$Menu.visible = true
	$HUD.visible = false
	$Pause.visible = false
	$Mute.visible = false

#función para crear un nivel nuevo
func new_level():
	#se comprueba si es nivel 1, 2 o 3 y se hace la instancia respectiva
	#y se muestra el fondo correspondiente 
	if lev == 1:
		n = Nivel1.instance()
		$Fondo1.visible = true
		$Fondo2.visible = false
		$Fondo3.visible = false
	elif lev == 2:
		n = Nivel2.instance()
		$Fondo1.visible = false
		$Fondo2.visible = true
		$Fondo3.visible = false
	else:
		n = Nivel3.instance()
		$Fondo1.visible = false
		$Fondo2.visible = false
		$Fondo3.visible = true
	$HUD/Level.text = str(lev)
	$Menu.visible = false
	$Pause.visible = true
	$HUD.visible = true
	$Mute.visible = true
	add_child(n)
	#se guarda el puntaje (calculado en el nivel)
	sco = n.get_node("score")
	get_tree().paused = false
	#se conecta la señal "out" con la función game_over
	n.connect("out", self, "game_over")
	#se inicia el timer
	$Timer.start()

#Función para cambiar de nivel, removiendo la instancia actual
func change_level():
	remove_child(n)
	new_level()

#Función para mostrar la animación y el botón restart
#cuando se termine el juego
func game_over():
	$HUD.visible = false
	$Pause.visible = false
	$Mute.visible = false
	$GO.visible = true
	$Restart.visible = true
	$Explosion.visible = true
	$Explosion.playing = true
	$Explosion2.visible = true
	$Explosion2.playing = true
	get_tree().paused = true

#Función para terminar el juego si se acaba el tiempo
func _on_Timer_timeout():
	game_over()

#Función para salir del juego si se hace click en Exit
func _on_Exit_pressed():
	get_tree().quit(-1)

#Funcón para ir al siguiente nivel si se hace click en Continue
func _on_Continue_pressed():
	lev += 1
	change_level()

#Función para pausar el juego, si se hace click en Pause
func _on_Pause_pressed():
	p = !p
	#cambia el texto entre Resume y Pause
	if p:
		$Pause.text = "Resume"
	else:
		$Pause.text = "Pause"
	show_menu()

#Función para ir un nivel atrás si se hace click en GoBack
func _on_GoBack_pressed():
	lev -= 1
	change_level()

#Función para reiniciar el juego si se hace click en restart
func _on_Restart_pressed():
	$GO.visible = false
	$Explosion.visible = false
	$Explosion.playing = false
	$Explosion2.visible = false
	$Explosion2.playing = false
	$Restart.visible = false
	
	lev = 1
	change_level()

#Función para mutear la música de fondo si se hace click en el botón
func _on_Mute_pressed():
	$ambiente.stream_paused = !$ambiente.stream_paused
