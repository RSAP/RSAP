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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


   #=============================
   has_attached_file :avatar, styles: {
      medium: "400x400>",
      thumb: "80x80>"
   }
   #, default_url: "/images/:style/missing.png"

   #Upload de apenas imagens (do tipo image)
   validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/



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

   def getAvatarThumb
      return self.avatar.url(:thumb)
   end

   def getAvatarMedium
      return self.avatar.url(:medium)
   end

end
