extends Node

func _ready():
    if %MouseOffset.button_pressed:
        %OriginCursor.modulate = Color.WHITE
    else:
        %OriginCursor.modulate = Color.BLACK

func _unhandled_input(event):

    if %MouseOffset.button_pressed:
        if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
            %OFFSETX.value = %MousePos.pos.x
            %OFFSETY.value = %MousePos.pos.y
            %OffsetCursor.UpdateCursor()
            OffsetColor()

    if Input.is_action_just_released("origin"):
        %MouseOffset.button_pressed = ! %MouseOffset.button_pressed
        OffsetColor()


func OffsetColor():
    if %MouseOffset.button_pressed:
        %OriginCursor.modulate = Color.WHITE
    else:
        %OriginCursor.modulate = Color.BLACK
    %LOG.text = "Offset tool is " + str( %MouseOffset.button_pressed)


func _on_mouse_offset_pressed():
    OffsetColor()
