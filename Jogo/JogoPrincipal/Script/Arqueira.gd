extends KinematicBody2D

var velocidade_atual = Vector2(0, 0)
var SPEED = 400
var GRAVITY = 2000
var dir_x = 1
var jump = 800
var puloDuplo = true

onready var texturaAndando = preload("res://Sprite/arqueira/andando.png")
onready var texturaParado = preload("res://Sprite/arqueira/parado.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	velocidade_atual.x = 0
	velocidade_atual.y += delta*GRAVITY
	if Input.is_action_pressed("Direita") and !Input.is_action_pressed("Esquerda"):
		velocidade_atual.x = SPEED
		dir_x = 1
		$Sprite.texture = texturaAndando
		
		$Sprite.flip_h = false	
	if Input.is_action_pressed("Esquerda") and !Input.is_action_pressed("Direita"):
		velocidade_atual.x = -SPEED
		dir_x = -1
		$Sprite.texture = texturaAndando
		
		$Sprite.flip_h = true
	if !Input.is_action_pressed("Direita") and !Input.is_action_pressed("Esquerda"):
		$Sprite.texture = texturaParado
	 
	if(is_on_floor()):
		puloDuplo = true
		velocidade_atual.y = 0
		if Input.is_action_just_pressed("Cima"):
			velocidade_atual.y -= jump
			
	elif puloDuplo:
		if Input.is_action_just_pressed("Cima"):
			puloDuplo = false
			velocidade_atual.y = -jump
	
	if(is_on_ceiling()):
		velocidade_atual.y = 0
	
	move_and_slide(velocidade_atual, Vector2(0, -1))
		
	pass
