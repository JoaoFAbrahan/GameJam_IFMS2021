extends Area2D

#### Efeito de colisão com o jogador
func _on_ItemTimer_body_entered(body):
	### Adiciona efeito
	body._AddTime(15);
	
	### Animação
	$AnimationPlayer.play("Collected");

#### Efeito pós colisão
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free();
