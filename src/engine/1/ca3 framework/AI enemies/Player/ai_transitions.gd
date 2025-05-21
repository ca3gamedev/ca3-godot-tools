extends Node

# THIS IS THE NODE THAT CONTROLS THE MOTION
@export var currentmotion : Node
# THIS HOLDS THE CURRENT STATE WITH THE START ()
@export var currentanim : Node
# THIS IS THE PARENT OF MOTION NODES
@export var motionparent : Node
# THIS IS THE PARENT OF ANIMATION NODES
@export var motionanimtree : Node

@export var idle : bool

func _ready():
	ChangeState("WALK")
	%Hitbox.get_node("CollisionShape2D").disabled = true


func _physics_process(delta):
	
	currentmotion.PhysicsUpdate(delta)
	currentanim.Update(delta)

func ChangeState(state):
	
	match(state):
		"IDLE" : 
			idle = true
			currentmotion = motionparent.get_node("IDLE")
			currentanim = motionanimtree.get_node("IDLE")
		"WALK" :
			idle = true
			currentmotion = motionparent.get_node("WALK")
			currentanim = motionanimtree.get_node("WALK")
		"PUNCH" :
			idle = false
			currentmotion = motionparent.get_node("IDLE")
			currentanim = motionanimtree.get_node("PUNCH")
			currentanim.Start()
		"HURT" :
			idle = false
			currentmotion = motionparent.get_node("IDLE")
			currentanim = motionanimtree.get_node("HURT")
			currentanim.Start()

func EndAnimations():
	%Anim.set("parameters/conditions/attack", false)
	%Anim.set("parameters/conditions/Hurt", false)
	
	%Hitbox.get_node("CollisionShape2D").disabled = true
	
	ChangeState("WALK")
	


func _on_hitstop_freeze_timeout():
	get_tree().get_root().get_node("Root/Players").call_deferred("set_process_mode", Node.PROCESS_MODE_INHERIT)
