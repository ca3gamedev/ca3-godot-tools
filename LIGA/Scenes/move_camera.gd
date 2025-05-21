extends Node

@export var speed: float
@export var multi: float

func _ready():
    ResetCamera()


func _process(delta):

    if Input.is_action_just_released("RESETCAMERA"):
        ResetCamera()

    if Input.is_action_just_released("PLUS"):
        %Camera2D.zoom += Vector2(0.1, 0.1)
    if Input.is_action_just_released("MINUS"):
        %Camera2D.zoom -= Vector2(0.1, 0.1)

    if not %BRUSH.button_pressed:
        if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
            var pos = %Camera2D.global_position
            pos = pos.lerp( %OriginCursor.get_global_mouse_position(), delta)
            %Camera2D.global_position = pos


func ResetCamera():
    var pos = Vector2i( %OFFSETX.value, %OFFSETY.value)
    var offsetpos = %"UnderLayer".to_global( %"UnderLayer".map_to_local(pos))
    %Camera2D.position = offsetpos
