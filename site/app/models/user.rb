class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

   #=============================
   has_attached_file :avatar, styles: { medium: "400x400>", thumb: "80x80>" }
   #, default_url: "/images/:style/missing.png"

   #Upload de apenas imagens (do tipo image)
   validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


   has_attached_file :avatar
   # Validate content type
   validates_attachment_content_type :avatar, content_type: /\Aimage/
   # Validate filename
   validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]
   # Explicitly do not validate
   do_not_validate_attachment_file_type :avatar

   #=============================


   def getNick
      return self.email.split('@')[0].capitalize
   end

   # def getAvatar
   #    return self.avatar
   # end

end
