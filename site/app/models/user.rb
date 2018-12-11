class User < ApplicationRecord

	#Relacionamento com amizades
	has_many :friendships
	has_many :received_friendships, class_name: "Friendship", foreign_key: "friend_id"

	has_many :active_friends, -> { where(friendships: { accepted: true}) }, through: :friendships, source: :friend
	has_many :received_friends, -> { where(friendships: { accepted: true}) }, through: :received_friendships, source: :user
	has_many :pending_friends, -> { where(friendships: { accepted: false}) }, through: :friendships, source: :friend
	has_many :requested_friendships, -> { where(friendships: { accepted: false}) }, through: :received_friendships, source: :user


	def friends
		active_friends | received_friends
	end


	def pending
		pending_friends | requested_friendships
	end
	############################################################################################3

	def self.all_except(user)
		where.not(id: user)
	end

	def self.search(search)
		if search
			where(['nome LIKE ?', "%#{search}%"])
		else
			all
		end
	end
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :registerable,
		:recoverable,
		:rememberable,
		:database_authenticatable
		#, :validatable #(validate padrão do devise [ingles])


	#Validacoes
	validates :nome, presence: { message: "Nome em branco"},
		length: { in: 4..130, too_short: "Nome deve ter pelo menos 4 caracteres",
		too_long: "Nome deve ter no maximo 130 caracteres"},
		format: { with: /\A[a-zA-Z\s]+\z/, message: "Nome nao pode conter caracteres especiais ou numeros" }

	validates :email, presence: { message: "Email em branco"},
		uniqueness: { message: "Email ja cadastrado"},
		format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email invalido" }

	validates :descricao, presence: { message: "Descricao em branco"},
		length: { in: 10..500, too_short: "Descricao muito curta (mínimo de 10 caracteres)",
		too_long: "Descricao muito longa (máximo 500 caracteres)"}

	validates :password, presence: { message: "Senha em branco"},
		length: { in: 6..32, too_short: "Senha deve conter pelo menos 6 caracteres",
		too_long: "Senha muito longa (máximo 25 caracteres)"},
		confirmation: {message: "Confirmacao nao bate com senha"}

	validates :password_confirmation, presence: { message: "Confirmacao em branco"}


	#Imagem:
	#=============================
	has_attached_file :avatar, styles: {
		medium: "400x400>",
		thumb: "80x80>"
	}
	#, default_url: "/images/:style/missing.png"

	#Upload de apenas imagens (do tipo image)
	# Validate content type
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/, message: "Formato de foto invalido"
	# Validate filename
	validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/], message: "Nome da foto invalido"
	#Restricao do tamanho do arquivo de upload
	validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 3.megabytes, message: "O tamanho do arquivo não pode ultra passar 3 MegaBytes"

	#=============================


	def getNick
		return self.email.split('@')[0].capitalize
	end

	def getAvatarThumb
		return self.avatar.url(:thumb)
	end

	def getAvatarMedium
		return self.avatar.url(:medium)
	end

	def getMeusPosts
		return self.posts
	end

end
