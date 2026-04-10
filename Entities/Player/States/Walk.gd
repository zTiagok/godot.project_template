class_name PlayerWalkState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity

func Update(_delta) -> void:
  if player.direction == Vector2.ZERO:
    stateMachine.ChangeState(PlayerIdleState)

  increaseDeceleration(_delta)


func PhysicsUpdate(_delta) -> void:
  # Movimenta o Player com base na direção escolhida.
  player.velocity = player.speed * player.direction.normalized()


func increaseDeceleration(time) -> void:
  if player.currentDeceleration >= 400.0:
    # Com o passar do tempo, aumentará a desaceleração que o Player tiver.
    player.currentDeceleration -= time * 200