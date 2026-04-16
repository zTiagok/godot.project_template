class_name PlayerMiningState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity
  player.canChangeDirection = false


func PhysicsUpdate(_delta) -> void:
  # Para o player.
  player.velocity = Vector2.ZERO


func Exit() -> void:
  player.canChangeDirection = true


func onAnimation() -> void:
  # Durante a animação, ativa a hitbox.
  player.hitbox.collision.disabled = false


func onAnimationEnd() -> void:
  # Desativa a hitbox para que caso a animação repita, o Hurtbox consiga detectar.
  player.hitbox.collision.disabled = true
  # No final da animação, checa se o Player ainda está segurando o botão da ferramenta.
  if !GameInputs.isUsingTool():
    if player.direction != Vector2.ZERO:
      stateMachine.ChangeState(PlayerWalkState)
    else:
      stateMachine.ChangeState(PlayerIdleState)
