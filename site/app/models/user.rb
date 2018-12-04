class User < ApplicationRecord
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

   # Validate content type
   validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/, message: "Formato de foto invalido"
   # Validate filename
   validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/], message: "Nome da foto invalido"
   # Explicitly do not validate
   # do_not_validate_attachment_file_type :avatar

   # validate :avatar_is_a_image, :avatar_is_less_than_two_megabytes


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
