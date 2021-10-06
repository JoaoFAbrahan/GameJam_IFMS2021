extends CanvasLayer

onready var player = get_parent().get_node("World Components/Main_Player");

func _process(delta):
	if !player.Life_Status():
		$GameOver.show();

func _input(event):
	if event.is_action_pressed("PlayerMenu_ESC") && player.Life_Status():
		get_node("MenuPausa").show()
		get_tree().paused = true

func _on_Continuar_pressed():
	get_tree().paused = false
	get_node("MenuPausa").hide()

func _on_MenuPrincipal_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://User Interface/Menu/Menu.tscn")

func _on_Sair_pressed():
	get_tree().quit()

func _on_Config_pressed():
	get_node("Sound").show()
	AudioServer.generate_bus_layout()

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)

func _on_FullScreen2_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
