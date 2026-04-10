@icon("res://Assets/Icons/2d/spark-hollow-white.png")
class_name State extends Node

var stateMachine : StateMachine
var entity : Entity


func Enter() -> void:
	entity.changeAnimation()

func Update(_delta) -> void:
	pass

func PhysicsUpdate(_delta) -> void:
	pass

func Exit() -> void:
	pass