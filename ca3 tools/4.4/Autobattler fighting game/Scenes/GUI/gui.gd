extends Node2D

var Combo : int = 0
var P1HP = 100
var P2HP = 100

var Winner = 0

func _ready() -> void:
	ResetCombo()
	ResetHP()
	WinnerLabel()

func ResetHP():
	P1HP = 100
	P2HP = 100
	%LifebarP1.value = P1HP
	%LifebarP2.value = P2HP

func WinnerLabel():
	%P1Win.hide()
	%P2Win.hide()
	if Winner == 1:
		%P1Win.show()
	if Winner == 2:
		%P2Win.show()

func ResetCombo():
	Combo = 0
	$%ComboLog.text = "HIT " + str(Combo)

func AddHit():
	Combo += 1
	$%ComboLog.text = "HIT " + str(floor(Combo / 2))

func HitP1(damage):
	P1HP -= damage
	%LifebarP1.value = P1HP
	if P1HP <= 0:
		Winner = 2
		WinnerLabel()
		ResetHP()
		ResetCombo()
		ResetScene.call_deferred()

func ResetScene():
	get_tree().change_scene_to_file("res://Scenes/Battle/Root 25 fighter/root.tscn")
		

func HitP2(damage):
	P2HP -= damage
	%LifebarP2.value = P2HP
	if P2HP <= 0:
		Winner = 1
		WinnerLabel()
		ResetHP()
		ResetCombo()
		ResetScene.call_deferred()
