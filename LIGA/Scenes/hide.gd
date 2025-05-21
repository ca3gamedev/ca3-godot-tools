extends Node

var hidden = false

func _process(delta):
    if Input.is_action_just_released("Hid"):
        hidden = !hidden

        if hidden:
            HIDE()
        else:
            SHOW()


func HIDE():
    %GUI.hide()
    %OriginCursor.hide()
    %EndCursor.hide()
    %OriginWorld.hide()
    %CanvasBorder.hide()

func SHOW():
    %GUI.show()
    %OriginCursor.show()
    %EndCursor.show()
    %OriginWorld.show()
    %CanvasBorder.show()
