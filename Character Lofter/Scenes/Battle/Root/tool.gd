extends OptionButton

var Tools = [
	"Draw Point (D)", "Extrude (E)", "Conect (F)", "Erase (X)",
]

var current_mode = Tools[0]

func _ready():
	
	for i in Tools:
		self.add_item(i)

func _process(delta):
	
	if Input.is_action_just_released("DRAW"):
		current_mode = Tools[0]
	if Input.is_action_just_released("EXTRUDE"):
		current_mode = Tools[1]
	if Input.is_action_just_released("CONNECT"):
		current_mode = Tools[2]
	if Input.is_action_just_released("ERASE"):
		current_mode = Tools[3]
	
	UpdateTool()

func UpdateTool():
	
	match (current_mode):
		"Draw Point (D)": self.selected = 0
		"Extrude (E)": self.selected = 1
		"Conect (F)": self.selected = 2
		"Erase (X)": self.selected = 3
