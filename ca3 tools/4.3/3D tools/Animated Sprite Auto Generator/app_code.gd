extends Node

# path of PC where the sprites are initially stored
@export var folder : String
# list of folders on the folder path
var folders = []
# number of pngs on the folder the app checks
var max_png = 0
#Variable to be able to return the current id of what is selected on 
#the preview folder itemlist
var current_anim = 0
#Save folder path
@export var savefolder : String
#First animatedsprite used to preview the animatedsprite animations
@export var spritesheet : AnimatedSprite3D
#Second animatedsprite used to preview the animationplayer animations
@export var spritesheet2 : AnimatedSprite3D

func _ready():
	#default code to initialized the preview of the folder
	var texture = Image.load_from_file("res://No.png")
	%tmpsprite.texture = ImageTexture.create_from_image(texture)
	%tmpspritelog.text = "NOT PNG FOUND"

func MakeAnimatedSprite():
	#This creates the %AniList itemlist list
	folders = []
	var dir = DirAccess.open(folder)
	folders = dir.get_directories()
	%AniList.clear()
	for i in folders:
		%AniList.add_item(i)


func _on_ani_list_item_selected(index):
	#This changes the Sprite to preview the AniList selection
	var files = []
	var path = folder + "/" + folders[index]
	files = DirAccess.get_files_at(path)
	var sprite = GetTmpFile(files)
	current_anim = index
	
	if sprite != "null":
		var texture = Image.load_from_file(path + "/" + sprite)
		%tmpsprite.texture = ImageTexture.create_from_image(texture)
		%tmpspritelog.text = str(int(max_png)) + " PNG FOUND"
	else:
		var texture = Image.load_from_file("res://No.png")
		%tmpsprite.texture = ImageTexture.create_from_image(texture)
		%tmpspritelog.text = "NOT PNG FOUND"

func GetTmpFile(file):
	#This checks if there's a png on the folder
	max_png = len(file)
	for i in file:
		
		## ****************************
		## CHANGE THIS IF YOU WANT TO ADD SUPORT FOR OTHER FILES BEYOND PNG
		## ****************************
		
		if i.get_extension() == "png":
			return i
	return "null"


func _on_clear_list_pressed():
	#This clears the AniList
	%AniList.clear()
	var texture = Image.load_from_file("res://No.png")
	%tmpsprite.texture = ImageTexture.create_from_image(texture)
	%tmpspritelog.text = "NOT PNG FOUND"


func _on_add_folder_pressed():
	if len(folders) > 0:
		if max_png > 0:
			# AddFolder is a function with checks to avoid duplicating animations
			# GetCurrentFolder gets the ID of the current selected animation
			var duplication = AddFolder(GetCurrentFolder())
			if duplication == "OK":
				%tmpspritelog.text = GetCurrentFolder() + " ADDED"
			elif duplication == "Empty":
				%tmpspritelog.text = "FOLDER CONTAIN NO PNG"
			else:
				%tmpspritelog.text = "FOLDER ALREADY EXIST"
		else:
			%tmpspritelog.text = "NO PNG TO ADD"
	else:
		%tmpspritelog.text = "NO FOLDERS TO ADD"

func GetCurrentFolder():
	#This returns the folders name
	return folders[current_anim]


func _on_add_all_folders_pressed():
	#This adds all folders you have on the ItemList
	#This check is to see if to avoid duplicating animations
	var duplicated = "OK"
	for i in folders:
		var tmp = AddFolder(i)
		if tmp != "OK":
			duplicated = tmp
	if duplicated == "Duplicated":
		%tmpspritelog.text = "Some folders already existed"
	elif duplicated == "Empty":
		%tmpspritelog.text = "Added folders but some folders contain no pngs"
	else:
		%tmpspritelog.text = "All folders were added, no error found"

func AddFolder(item):
	#This adds a folder
	var found = false
	for i in %AnimationsList.item_count:
		if %AnimationsList.get_item_text(i) == item:
			found = true
	if not found:
		
		var path3 = folder + "/" + item
		var tmpfiles = DirAccess.get_files_at(path3)
		var sprite = GetTmpFile(tmpfiles)
		if sprite != "null":
			%AnimationsList.add_item(item)
			return "OK"
		else:
			return "Empty"
	return "Duplicated"


func _on_generate_ani_pressed():
	# This is the important function where you generates the animated Sprite
	# and Animation Player
	if %AnimationsList.item_count > 0:
		#spritesheet.sprite_frames.clear_all()
		
		for i in %AnimationsList.item_count:
			var path2 = folder + "/" + %AnimationsList.get_item_text(i)
			var files2 = DirAccess.get_files_at(path2)
			var sprite = GetTmpFile(files2)
			if sprite != "null":
				spritesheet.sprite_frames.add_animation(%AnimationsList.get_item_text(i))
				for png in files2:
					
					# **********************************
					# CHANGE THIS TO SUPPORT OTHER FORMATS
					# **********************************
					
					if png.get_extension() == "png":
						#var texture = Image.load_from_file(path2 + "/" + png)
						#var imagetexture = ImageTexture.create_from_image(texture)
						var texture = load(path2 + "/" + png)
						spritesheet.sprite_frames.add_frame(%AnimationsList.get_item_text(i), texture)
				
				# This plays the last selected animation, so the user can
				# see the animation was baked properly
				spritesheet.play(%AnimationsList.get_item_text(i))
		# This resets the animationList preview
		%AnimationsListPreview.clear()
		for i2 in %AnimationsList.item_count:
			%AnimationsListPreview.add_item(%AnimationsList.get_item_text(i2))
		#spritesheet2.sprite_frames.clear_all()
		# This copies from the animatedSprite Tab into the animationplayer tab animatedsprite
		spritesheet2.sprite_frames = spritesheet.sprite_frames
		spritesheet2.animation = %AnimationsList.get_item_text(0)
		
		# This resets the list of the animationplayer tab
		%AnimationPlayerList.clear()
		for i3 in %AnimationsListPreview.item_count:
			%AnimationPlayerList.add_item(%AnimationsListPreview.get_item_text(i3))
		
		# This calls the function to generate the AnimationPlayer animations
		# It uses an absolute path because I don't want to use % or any type of link
		# So the exported scene is free from any reference
		$"../../Panel/Pictures/AnimationPlayerPreview/Sprites/Code".AddFrames()
	else:
		%AnimatedSpriteLog.text = "NO ANIMATIONS FOUND"


func _on_animations_list_preview_item_selected(index):
	#This checks if animation list is not empty
	if %AnimationsList.item_count > 0:
		spritesheet.play(%AnimationsList.get_item_text(index))


func _on_saveanimatedsprite_pressed():
	# This saves the animated Sprite into the user files
	var animatedsprite = PackedScene.new()
	var animatedspritepacked = animatedsprite.pack(%SpriteSheet)
	if animatedspritepacked == OK:
		var error = ResourceSaver.save(animatedsprite, savefolder + "/" + "AnimatedSprite.tscn")
		if error != OK:
			%Log.text = "There was an error, couldn't save the animated sprite file"
		else:
			%Log.text = "Saved sucesfully"


func _on_animation_player_list_item_selected(index):
	# "sprites/" is how you select the animation library that contains the animation
	%Animations.play("sprites/" + %AnimationPlayerList.get_item_text(index))
