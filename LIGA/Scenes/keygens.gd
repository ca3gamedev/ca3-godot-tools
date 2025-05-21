extends Node

var current_layer = 0
var current_tilemap

@export var UnderLayer: TileMapLayer
@export var UnderMidLayer: TileMapLayer
@export var MiddleLayer: TileMapLayer
@export var UpperMidLayer: TileMapLayer
@export var UpperLayer: TileMapLayer

func _ready():
    ChangeCurrent()

func _process(delta):

    if Input.is_action_just_released("RockLayer"):
        SetID(0)
    if Input.is_action_just_released("SandLayer"):
        SetID(1)
    if Input.is_action_just_released("GrassLayer"):
        SetID(2)
    if Input.is_action_just_released("BushLayer"):
        SetID(3)
    if Input.is_action_just_released("FoliageLayer"):
        SetID(4)


func SetID(id):
    current_layer = id
    %LAYER.select(id)
    %LOG.text = GetNameLayer(id) + " Layer Selected"
    ChangeCurrent()


func GetNameLayer(id):
    var name = "none"
    match (id):
        0: name = "Under"
        1: name = "Under Mid"
        2: name = "Middle"
        3: name = "Middle Upper"
        4: name = "Upper"

    return name


func ChangeCurrent():
    match ( %LAYERS.current_layer):
        0: current_tilemap = UnderLayer
        1: current_tilemap = UnderMidLayer
        2: current_tilemap = MiddleLayer
        3: current_tilemap = UpperMidLayer
        4: current_tilemap = UpperLayer



func _on_layer_item_selected(index):
    var id = %LAYER.selected
    current_layer = id
    %LOG.text = GetNameLayer(id) + " Layer Selected"
    ChangeCurrent()
