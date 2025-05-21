extends Node2D

@export var hardrock: Color
@export var rock: Color
@export var clay: Color
@export var sand: Color
@export var few_grass: Color
@export var sabana: Color
@export var bush: Color
@export var flowers: Color
@export var grass: Color
@export var fewpath: Color
@export var mainpath: Color

func SetColor(colour):



    SetTile("rock")

    match (colour):
        Color(0, 0, 0): SetTile("rock")
        Color(0.25, 0, 0): SetTile("clay")
        Color(0.5, 0, 0): SetTile("clay")
        Color(0.75, 0, 0): SetTile("hardrock")
        Color(1, 0, 0): SetTile("hardrock")

    if colour.b == 0:
        if colour.g > 0 and colour.g < 0.35:
            SetTile("sand")
        if colour.g > 0.39 and colour.g < 0.41 and colour.r < 0.2:
            SetTile("bush")
        if colour.g > 0.39 and colour.g < 0.41 and colour.r > 0.45:
            SetTile("few grass")
        if colour.g > 0.5 and colour.g < 0.85:
            SetTile("sabana")
        if colour.g > 0.74:
            SetTile("grass")

    if colour.b < 0.59 and colour.b > 0.2:
        SetTile("few path")
    if colour.b > 0.59:
        SetTile("main path")

func ChangeColor(colour):
    $ColorRect.modulate = colour

func SetTile(name):
    match (name):
        "hardrock": ChangeColor(hardrock)
        "rock": ChangeColor(rock)
        "clay": ChangeColor(clay)
        "sand": ChangeColor(sand)
        "few grass": ChangeColor(few_grass)
        "sabana": ChangeColor(sabana)
        "bush": ChangeColor(bush)
        "flowers": ChangeColor(flowers)
        "grass": ChangeColor(grass)
        "few path": ChangeColor(fewpath)
        "main path": ChangeColor(mainpath)
