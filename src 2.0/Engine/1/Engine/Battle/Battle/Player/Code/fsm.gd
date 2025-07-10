extends Node

class_name FSM

var current: Node = null

func _ready():
	# Set default state, e.g., Idle
	change_state("Idle")

func _process(delta):
	
	if current and current.has_method("_transitions"):
		current._update(delta)
	
	if current and current.has_method("_update"):
		current._update(delta)

func _physics_process(delta):
	if current and current.has_method("_physics_update"):
		current._physics_update(delta)

func _input(event):
	if current and current.has_method("_handle_input"):
		current._handle_input(event)

func change_state(state_name: String):
	if not %STATES.states.has(state_name):
		print("State '%s' not found in state_map" % state_name)
		return

	var child_node_name = %STATES.states[state_name]
	var new_state = get_node_or_null(child_node_name)

	if new_state == null:
		print("Child node '%s' not found in FSM" % child_node_name)
		return
		
	current = new_state
	
	%LOG.text = str(current.name)

	if current.has_method("enter"):
		current.start()
