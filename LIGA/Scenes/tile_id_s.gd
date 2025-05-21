extends OptionButton

func _ready():

    add_item("Black")
    add_item("White")
    add_item("Deep Water")
    add_item("Light Water")
    add_item("Sand")
    add_item("Clay")
    add_item("Rocks")
    add_item("Snow")
    add_item("Grass")
    add_item("Grass Leaves")
    add_item("Lava")
    add_item("Flower")
    add_item("Bricks")
    add_item("Grass Patch")
    add_item("Wood")
    add_item("Stick")
    add_item("House")
    add_item("Forest")
    add_item("Tree")
    add_item("Stone Wall")

func _on_item_selected(index):
    $Icon.set_cell(Vector2i.ZERO, index, Vector2i.ZERO)
