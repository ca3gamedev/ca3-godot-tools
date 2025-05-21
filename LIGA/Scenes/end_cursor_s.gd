extends Node

func _ready():
    UpdateCursor()


func UpdateCursor():
    var pos = Vector2i.ZERO
    pos.x = %Math.ClampX( %ENDX.value)
    pos.y = %Math.ClampY( %ENDY.value)
    %EndCursor.global_position = %"UnderLayer".to_global( %"UnderLayer".map_to_local(pos))


func _unhandled_input(event):

    if %EndOffset.button_pressed:
        if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
            %ENDX.value = %MousePos.pos.x
            %ENDY.value = %MousePos.pos.y
            UpdateCursor()

    if Input.is_action_just_released("endorigin"):
        %EndOffset.button_pressed = ! %EndOffset.button_pressed
