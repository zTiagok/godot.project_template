extends Node

var hairCollection : Dictionary[CustomizationTypes.HairTypes, CompressedTexture2D] = {
  CustomizationTypes.HairTypes.BowHair: preload("res://Assets/Sprites/Player/IDLE/bowlhair_idle_strip9.png"),
  CustomizationTypes.HairTypes.CurlyHair: preload("res://Assets/Sprites/Player/IDLE/curlyhair_idle_strip9.png"),
  CustomizationTypes.HairTypes.LongHair: preload("res://Assets/Sprites/Player/IDLE/longhair_idle_strip9.png"),
  CustomizationTypes.HairTypes.MopHair: preload("res://Assets/Sprites/Player/IDLE/mophair_idle_strip9.png"),
  CustomizationTypes.HairTypes.ShortHair: preload("res://Assets/Sprites/Player/IDLE/shorthair_idle_strip9.png"),
  CustomizationTypes.HairTypes.SpikeyHair: preload("res://Assets/Sprites/Player/IDLE/spikeyhair_idle_strip9.png"),
}

var toolCollection : Dictionary[CustomizationTypes.ToolTypes, CompressedTexture2D] = {
  CustomizationTypes.ToolTypes.None: preload("res://Assets/Sprites/Player/IDLE/tools_idle_strip9.png")
}

var hairSelected : CustomizationTypes.HairTypes = CustomizationTypes.HairTypes.BowHair
var toolSelected : CustomizationTypes.ToolTypes = CustomizationTypes.ToolTypes.None
