extends Node2D

func _ready():
	pass
	
func _process(delta):
	if Input.is_action_just_released('click'):
		var mouse = get_viewport().get_mouse_position()
		
		if Physics.point_inside_rect_array(mouse[0], mouse[1], UI.start_button):
			get_tree().change_scene('res://Scene/game.tscn')
