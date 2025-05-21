extends Node

func Check(x, y):
    if x < %Canvas.pos.x + 1:
        return false
    if x > ( %Canvas.pos.x + %Canvas.width) - 1:
        return false
    if y < %Canvas.pos.y + 1:
        return false
    if y > ( %Canvas.pos.y + %Canvas.height) - 1:
        return false

    return true

func ClampX(x):
    return clampi(x, %Canvas.pos.x, %Canvas.pos.x + %Canvas.width)

func ClampY(y):
    return clampi(y, %Canvas.pos.y, %Canvas.pos.y + %Canvas.height)

func ClampV2(x, y):
    return Vector2i(ClampX(x), ClampY(y))
