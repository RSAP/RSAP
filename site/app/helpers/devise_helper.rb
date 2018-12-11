module DeviseHelper
	def devise_error_messages!
		return "" unless devise_error_messages?

		messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
		sentence = I18n.t("errors.messages.not_saved",
			:count => resource.errors.count,
			:resource => resource.class.model_name.human.downcase)

			#error_messages_for 'model', :header_message => "You have some errors that prevented saving this model"

			# TODO: fazer for para retirar os duplicados

			messages = removerRepetidas(messages)

			html = <<-HTML
			<div id="error_explanation">
				<h2>#{sentence}</h2>
				<ul>#{messages}</ul>
			</div>
			HTML

			html.html_safe
		end

		def devise_error_messages?
			!resource.errors.empty?
		end

		def removerRepetidas(msgOriginal)
			#dividir num vetor
			vetorA = msgOriginal.split('</li>')
			#concatena com oq ue foi removido na divisao
			vetorA.map { |e| e.to_s << "</li>"  }
			#remove os repetidos
			vetorA = vetorA.uniq

			#remove msgs que n precisam
			vetorA = removerNaoNecessarias(vetorA)

			#Junta tudo em uma string novamente
			final = ""
			for i in vetorA
				final << i
			end


			#retorna uma string
			return final
		end

		def removerNaoNecessarias(msg)
			#Banco de msgs que n precisam ser mostradas (lembrar: <li></li>)
			semPrecisao = ['<li>has contents that are not what they are reported to be</li>',
				 '<li>is invalid</li>']

			final = []
			for i in msg
				igual = false
				for k in semPrecisao
					#Se for igual a alguma que n precisa
					if i == k
						igual = true
					end
				end
				#Se aquel eh alguma que n precisa
				if igual == true
					next
				end
				if k == semPrecisao.last
					final << i
				end
			end

			return final
		end

	end
