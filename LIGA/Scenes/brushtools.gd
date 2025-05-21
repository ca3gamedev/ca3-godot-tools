extends Node


func _unhandled_input(event):

    if %BRUSH.button_pressed:

        if not %Math.Check( %MousePos.pos.x, %MousePos.pos.y):
            return

        if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
            %LAYERS.current_tilemap.set_cell( %MousePos.pos, %TileID1.selected, Vector2i.ZERO)

        if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
            %LAYERS.current_tilemap.set_cell( %MousePos.pos, -1, Vector2i.ZERO)

func _process(delta):

    if Input.is_action_just_released("brush"):
        %BRUSH.button_pressed = ! %BRUSH.button_pressed

        %LOG.text = "Brush tool is " + str( %BRUSH.button_pressed)


func _on_brush_pressed():
    %LOG.text = "Brush tool is " + str( %BRUSH.button_pressed)
