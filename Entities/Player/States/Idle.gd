class_name PlayerIdleState extends State

var player : Player

func Enter() -> void:
  player = entity

func Update(_delta) -> void:
  # Troca para o "Walk" caso pressione alguma direção.
  if GameInputs.getDirections() != Vector2.ZERO:
    stateMachine.ChangeState(PlayerWalkState)