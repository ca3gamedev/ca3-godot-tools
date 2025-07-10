extends Node

func AddSkill(name, dir, button):
	if name == "double tap":
		%AddSkill.AddDash(dir, button)
		%SpecialList.AddItem("Double Tap", dir, button)
	if name == "charge":
		%AddSkill.AddCharge(dir, button)
		%SpecialList.AddItem("Charge", dir, button)
	if name == "hadouken":
		%AddSkill.AddHadouken(dir, button)
		%SpecialList.AddItem("Hadouken", dir, button)
	if name == "dragon punch":
		%AddSkill.AddDragonPunch(dir, button)
		%SpecialList.AddItem("Dragon Punch", dir, button)
	if name == "half circle":
		%AddSkill.AddHalfCircle(dir, button)
		%SpecialList.AddItem("Half Circle", dir, button)
	if name == "double hadouken":
		%AddSkill.Add2626(dir, button)
		%SpecialList.AddItem("Double Hadouken", dir, button)
	if name == "parry":
		%AddSkill.AddJustTap(dir)
		%SpecialList.AddItem("Parry", dir, "")
	if name == "mash":
		%AddSkill.AddMash(button)
		%SpecialList.AddItem("Mash", "", button)
