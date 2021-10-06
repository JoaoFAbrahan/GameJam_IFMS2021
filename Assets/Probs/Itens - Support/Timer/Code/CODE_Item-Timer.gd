extends Area2D

var alreadyCollected = false;

#### Efeito de colisão com o jogador
func _on_ItemTimer_body_entered(body):
	### Verifica se o item já foi coletado uma vez
	if(alreadyCollected == false):
		### Já coletou o item
		alreadyCollected = true;
		
		### Adiciona efeito
		body._AddTime(10);
		
		### Efeito Sonoro
		$CollectTimer_SFX.play();
		
		### Animação
		$AnimationPlayer.play("Collected");

#### Efeito pós colisão
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Collected":
		queue_free();
