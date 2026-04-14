class_name HurtboxComponent extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D

func onHitboxContact(hitbox: HitboxComponent) -> void:
  var attacker = hitbox.owner
  var damage = hitbox.damage
  var target = get_parent()

  if target is StaticEntity:
    # Caso seja um StaticEntity e não tenha as mesmas ferramentas, irá ignorar
    # o código.
    if attacker.currentTool != target.neededTool:
      return

  applyDamage(damage)


func applyDamage(damage: float) -> void:
  print("APLICANDO DANO: ", damage)
