extends Area2D

#### Respawna o jogador caso ele colida com esse objeto
func _on_Fallzone_body_entered(body):
	body.global_position = Vector2(0,0);
