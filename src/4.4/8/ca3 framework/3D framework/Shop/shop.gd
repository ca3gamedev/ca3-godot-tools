extends Area3D

var idle = false

var id = 0

func _ready():
	%StoreLabel.hide()
	%Store.hide()

func _on_body_entered(body):
	
	if body.is_in_group("PLAYER"):
		idle = true
		%StoreLabel.show()
	

func _on_body_exited(body):
	
	if body.is_in_group("PLAYER"):
		idle = false
		%StoreLabel.hide()


func _process(delta):
	
	var target = %Store.get_node(str(id)).global_position.y
	%Cursor.global_position.y = lerp(%Cursor.global_position.y, target, delta * 4)
	
	if idle:
		if Input.is_action_just_released("B"):
			id = 0
			%Cursor.global_position.y = $"Store/0".global_position.y
			%Store.show()
			$"../".PAUSE()
			$"../".is_store = true
			%Coins.text = str(VariableNodes.coins) + " Coins"

	if $"../".is_store:
		if Input.is_action_just_released("UP"):
			if id > 0:
				id -= 1
		
		if Input.is_action_just_released("DOWN"):
			if id < 2:
				id += 1
		
		if Input.is_action_just_released("A"):
			match(id):
				0 : 
					if VariableNodes.coins > 20:
						VariableNodes.coins -= 20
						VariableNodes.HP += 20
						VariableNodes.HP = clampi(VariableNodes.HP, 0, 100)
						%Coins.text = str(VariableNodes.coins) + " Coins"
				1 :
					if VariableNodes.coins > 60:
						VariableNodes.coins -= 20
						VariableNodes.HP += 80
						VariableNodes.HP = clampi(VariableNodes.HP, 0, 100)
						%Coins.text = str(VariableNodes.coins) + " Coins"
				2 :
					$"../".is_store = false
					$"../".UNPAUSE()
					%Store.hide()
