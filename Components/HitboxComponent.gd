class_name HitboxComponent extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D

func _on_area_entered(area: Area2D) -> void:
  # Caso exista um hurtbox, enviará os dados contidos na hitbox.
  if area is HurtboxComponent:
    area.onHitboxContact(self)