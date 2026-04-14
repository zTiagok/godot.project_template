class_name Entity extends CharacterBody2D

@onready var stateMachine : StateMachine = $StateMachine
@onready var animation : AnimationPlayer = $AnimationPlayer
@onready var hitbox : HitboxComponent = $HitboxComponent
@onready var hurtbox : HitboxComponent = $HurtboxComponent

func changeAnimation() -> void:
  pass