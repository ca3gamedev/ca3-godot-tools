extends Node

@onready var current = %GeneratorCode


func _on_clean_gen_pressed():
    CleanGen()


func _on_add_gen_pressed():
    ADDFILL()

func _process(delta):

    if Input.is_action_just_released("CleanGen"):
        CleanGen()
    if Input.is_action_just_released("AddGen"):
        ADDFILL()
    if Input.is_action_just_released("Algo1"):
        current.Algo1()
    if Input.is_action_just_released("Algo2"):
        current.GenerateBush()
    if Input.is_action_just_released("RandomWalk"):
        current.RandomWalk()
    if Input.is_action_just_released("PathWalk"):
        current.DirectWalk()
    if Input.is_action_just_released("RandomPos"):
        current.RandomPos()
    if Input.is_action_just_released("Clear"):
        current.Clear()


func _on_clear_pressed():
    current.Clear()

func ADDFILL():
    current.ADDFILL()

func CleanGen():
    current.NEWFILL()
