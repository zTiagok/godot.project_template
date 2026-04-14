@icon("res://Assets/Icons/2d/die-1-blue.png")
class_name StaticEntity extends StaticBody2D

@onready var hurtbox : HurtboxComponent = $HurtboxComponent
@onready var collision : CollisionShape2D = $CollisionShape2D

@export var neededTool : DataTypes.ToolTypes = DataTypes.ToolTypes.None


func _ready() -> void:
  collision_layer = LayerTypes.WORLD
  collision_mask = LayerTypes.PLAYER | LayerTypes.ENEMY | LayerTypes.COLLECTABLES | LayerTypes.INTERACTABLES