class_name HurtboxComponent extends Area2D

@onready var collision : CollisionShape2D = $CollisionShape2D
var target

func onHitboxContact(hitbox: HitboxComponent) -> void:
  var attacker = hitbox.owner
  target = get_parent()

  if target is StaticEntity:
    # Caso seja um StaticEntity e não tenha as mesmas ferramentas, irá ignorar
    # o código.
    if attacker.currentTool != target.neededTool:
      return

  applyDamage(attacker.stats as StatsComponent)


func applyDamage(attackerStats: StatsComponent) -> void:
  var targetStats: StatsComponent = target.stats
  targetStats.health -= attackerStats.damage

  if targetStats.health <= 0:
    target.onDestroyed()