class_name Player extends Entity

@export var label : Label
@export var speed : float = 20.0

func _process(_delta):
  label.text = stateMachine.currentState.name

func _physics_process(_delta: float) -> void:
  pass