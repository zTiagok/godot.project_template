class_name PlayerWalkState extends State

var player : Player

func Enter() -> void:
  super()
  player = entity

func Update(_delta) -> void:
  if player.direction == Vector2.ZERO:
    stateMachine.ChangeState(PlayerIdleState)

func PhysicsUpdate(_delta) -> void:
  # Movimenta o Player com base na direção escolhida.
  player.velocity = player.speed * player.direction