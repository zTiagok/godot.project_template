class_name Player extends Entity

@export var label : Label

func _process(_delta):
  label.text = stateMachine.currentState.name