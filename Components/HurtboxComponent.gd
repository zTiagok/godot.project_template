class_name HurtboxComponent extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D

func onHit(damage: float) -> void:
  print("DEU DANO!: ", damage)
  pass