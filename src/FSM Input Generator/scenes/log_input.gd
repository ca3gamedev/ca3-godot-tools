extends Node

@onready var buffer = get_tree().get_root().get_node("INPUT/Buffer")

func _process(delta):
	
	if buffer == null:
		return
	
	%KEYSLOG.text = str(buffer.ortho_dir)
	%BUTTONLOG.text = str(buffer.button)
	%DIALOG.text = str(buffer.dia_dir)
	
	var children = $"../../INPUT/FSM/Move".get_children()
	if children.size() > 0:
		if is_instance_valid(children[0]):
			var move = children[0].InputCheck()
			%MovementLog.text = str(move)
	
	
	var charge = GetCharge()
	%CHARGELOG.text = str(charge)
	var special = str($"../../INPUT".GetInput())
	if special != "none":
		%SpecialsLog.text = special
	
	if charge.size() > 0:
		%Charge0.text = str(charge[0])
	else:
		%Charge0.text = "0.0"
		%SpecialsLog.text = "none"
	
	%DashLog.text = str(buffer.rel_dir)

func GetCharge():
	var tmp = []
	for i in len(buffer.charge):
		tmp.append(round(buffer.charge[i] * 10) / 10)
	return tmp
