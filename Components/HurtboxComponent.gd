extends Area2D

var entity : Entity

func _on_area_entered(area: Area2D) -> void:
  if area is HitboxComponent:
    entity = get_parent()
    print("OK") 
    print("Entidade: ", entity)