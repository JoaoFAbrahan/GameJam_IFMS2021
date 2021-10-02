extends Area2D

#### Efeito de colisão com o jogador
func _on_ItemMop_body_entered(body):
	### Adiciona efeito
	body._AddScore(50);
	
	### Efeito Sonoro
	$CollectMop_SFX.play();
	
	### Animação
	$AnimationPlayer.play("Collected");

#### Efeito pós colisão
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free();
