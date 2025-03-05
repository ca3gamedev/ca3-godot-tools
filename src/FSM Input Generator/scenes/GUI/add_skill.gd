extends Node

@export var special2626 : PackedScene
@export var charge : PackedScene
@export var dash : PackedScene
@export var dragonpunch : PackedScene
@export var hadouken : PackedScene
@export var halfcircle : PackedScene
@export var justtap : PackedScene
@export var mash : PackedScene

@onready var special = get_tree().get_root().get_node("INPUT/FSM/Special")

func Add2626(dir, button):
	var tmp = special2626.instantiate()
	tmp.dir = dir
	tmp.button = button
	return AddChild(tmp)

func AddCharge(dir, button):
	var tmp = charge.instantiate()
	tmp.dir = dir
	tmp.button = button
	return AddChild(tmp)

func AddDash(dir, button):
	var tmp = dash.instantiate()
	tmp.dir = dir
	tmp.button = button
	return AddChild(tmp)

func AddDragonPunch(dir, button):
	var tmp = dragonpunch.instantiate()
	tmp.dir = dir
	tmp.button = button
	return AddChild(tmp)

func AddHadouken(dir, button):
	var tmp = hadouken.instantiate()
	tmp.dir = dir
	tmp.button = button
	return AddChild(tmp)

func AddHalfCircle(dir, button):
	var tmp = dragonpunch.instantiate()
	tmp.dir = dir
	tmp.button = button
	return AddChild(tmp)

func AddJustTap(dir):
	var tmp = justtap.instantiate()
	tmp.dir = dir
	return AddChild(tmp)

func AddMash(button):
	var tmp = mash.instantiate()
	tmp.button = button
	return AddChild(tmp)

func AddChild(scene):
	special.add_child(scene)
	scene.owner = special
	return true
	
