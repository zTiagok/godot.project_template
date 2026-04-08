class_name PlayerIdleState extends State

var player : Player

func Enter() -> void:
  player = entity

func Update(_delta) -> void:
  if GameInputs.getDirections() != Vector2.ZERO:
    stateMachine.ChangeState(PlayerWalkState)