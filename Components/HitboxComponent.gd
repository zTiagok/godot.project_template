class_name HitboxComponent extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D

var currentTool : DataTypes.ToolTypes
var damage : float = 1


func _on_area_entered(area: Area2D) -> void:
  # Caso exista um hurtbox, pegará o pai.
  if area is HurtboxComponent:
    var target = area.get_parent()

    # Caso o pai seja um StaticBody, verificará se a ferramenta coincide.
    if target is StaticEntity:
      currentTool = get_parent().currentTool

      print("Needed Tool: ", target.neededTool)
      print("Current Tool: ", currentTool)
      if target.neededTool == currentTool:
        print("Tá batendo a ferramenta")
        area.onHit(damage)