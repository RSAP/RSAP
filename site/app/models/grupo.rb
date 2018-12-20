class Grupo < ApplicationRecord

	#TODO: FALTA A IMAGEM DO GRUPO, MAS PAPERCLIP RESOLVE RAPIDIN

	validates :nome, presence: { message: "Nome em branco"},
		length: { in: 4..130, too_short: "Nome deve ter pelo menos 4 caracteres",
		too_long: "Nome deve ter no maximo 130 caracteres"},
		format: { with: /\A[a-zA-Z\s]+\z/, message: "Nome nao pode conter caracteres especiais ou numeros" }
	validates :descricao, presence: { message: "Descricao em branco"},
		length: { in: 4..130, too_short: "Descricao deve ter pelo menos 4 caracteres",
		too_long: "Descricao deve ter no maximo 130 caracteres"}


	#MEBROS
	def getUsers
		userIds = pegarDaTabela('user_id', 'grupos_users')
		return User.find(userIds.rows)
	end

	def addUser(user)
		addNaTabela(user, 'grupos_users')
	end

	def removerUser(user)
		removerDeTabela(user, 'grupos_users')
	end


	#MODERADORES
	def getModeradores
		userIds = pegarDaTabela('user_id', 'moderadores')
		return User.find(userIds.rows)
	end

	def addModerador(user)
		addNaTabela(user, 'moderadores')
	end

	def removerModerador(user)
		removerDeTabela(user, 'moderadores')
	end

	#Solicitacoes
	def getSolicitacoes
		userIds = pegarDaTabela('user_id', 'solicitacoes_grupo')
		return User.find(userIds.rows)
	end

	def addSolicitacao(user)
		addNaTabela(user, 'solicitacoes_grupo')
	end

	def removerSolicitacao(user)
		removerDeTabela(user, 'solicitacoes_grupo')
	end


	def removerDeTabelaGrupo user
		execQuerry("DELETE FROM moderadores WHERE grupo_id = #{user.id}")
		execQuerry("DELETE FROM grupos_users WHERE grupo_id = #{user.id}")
		execQuerry("DELETE FROM solicitacoes_grupo")
		#TODO
		execQuerry("DELETE FROM grupos WHERE id = #{self.id}")
		removerDeTabela()
	end

	private
	def execQuerry(sql)
		return ActiveRecord::Base.connection.exec_query(sql)
	end

	def removerDeTabela(user, tabela)
		execQuerry("DELETE FROM #{tabela} WHERE user_id = #{user.id}")
	end

	def addNaTabela(user, tabela)
		execQuerry("INSERT INTO #{tabela} (user_id, grupo_id, created_at, updated_at) VALUES (#{user.id}, #{self.id}, '#{Time.now.getutc}', '#{Time.now.getutc}')")
	end

	def pegarDaTabela(coluna, tabela)
		return execQuerry("SELECT #{coluna} FROM #{tabela} WHERE grupo_id = #{self.id}")
	end


end
