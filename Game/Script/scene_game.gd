extends Node

onready var player_node_elemental = get_node('PlayerElemental')
onready var player_node_machine = get_node('PlayerMachine')

func _ready():
	player_mode_set(0)
	map_generate()

func _process(delta):
	player_move(delta)
	input_handle()
	
func input_handle():
	if Input.is_action_just_pressed('left'):
		Variable.input['left'] = true
		
	if Input.is_action_just_pressed('right'):
		Variable.input['right'] = true
		
	if Input.is_action_just_pressed('up'):
		Variable.input['up'] = true
		
	if Input.is_action_just_pressed('down'):
		Variable.input['down'] = true
		
	if Input.is_action_just_pressed('toggle_mode'):
		if VarPlayer.elemental_mode == false:
			VarPlayer.elemental_mode = true
			player_mode_set(1)
		elif VarPlayer.elemental_mode == true and Physics.distance_between_two_point(VarPlayer.position_machine, VarPlayer.position_elemental) < 32:
			VarPlayer.elemental_mode = false
			player_mode_set(0)
	
	if Input.is_action_just_released('left'):
		Variable.input['left'] = false
		
	if Input.is_action_just_released('right'):
		Variable.input['right'] = false
		
	if Input.is_action_just_released('up'):
		Variable.input['up'] = false
		
	if Input.is_action_just_released('down'):
		Variable.input['down'] = false

func map_generate():
	var node_map = get_node('Map')
	
	for i in range(15):
		for j in range(20):
			if Variable.block[i][j] == 1:
				var temp_sprite = Sprite.new()
				temp_sprite.texture = Data.texture_floor
				temp_sprite.centered = false
				temp_sprite.position = Vector2(j * 40, i * 40)
				add_child_below_node(node_map, temp_sprite)

func player_move(delta):
	var temp_position_elemental = VarPlayer.position_elemental
	var temp_position_machine = VarPlayer.position_machine
	
	if VarPlayer.elemental_mode == true:
		if Variable.input['up'] == true:
			temp_position_elemental.y -= VarPlayer.speed * delta
		elif Variable.input['down'] == true:
			temp_position_elemental.y += VarPlayer.speed * delta
		elif Variable.input['left'] == true:
			temp_position_elemental.x -= VarPlayer.speed * delta
		elif Variable.input['right'] == true:
			temp_position_elemental.x += VarPlayer.speed * delta
			
	elif VarPlayer.elemental_mode == false:
		if Variable.input['left'] == true:
			temp_position_machine.x -= VarPlayer.speed * delta
			temp_position_elemental.x -= VarPlayer.speed * delta
		elif Variable.input['right'] == true:
			temp_position_machine.x += VarPlayer.speed * delta
			temp_position_elemental.x += VarPlayer.speed * delta
	
	player_node_elemental.position = temp_position_elemental
	player_node_machine.position = temp_position_machine
	VarPlayer.position_elemental = temp_position_elemental
	VarPlayer.position_machine = temp_position_machine
	
func player_mode_set(mode):
	if mode == 0:
		player_node_elemental.visible = false
		player_node_machine.get_node('MachineOff').visible = false
		player_node_machine.get_node('MachineOn').visible = true
		player_node_elemental.position = VarPlayer.position_machine
		VarPlayer.position_elemental = VarPlayer.position_machine
		
	elif mode == 1:
		player_node_elemental.visible = true
		player_node_machine.get_node('MachineOff').visible = true
		player_node_machine.get_node('MachineOn').visible = false
