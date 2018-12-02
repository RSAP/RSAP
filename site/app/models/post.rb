class Post < ApplicationRecord
  belongs_to :user

	validates :titulo, presence: { message: " em branco" }, length: { in: 5..100, too_short: "muito curto (deve ser maior que 4 caracteres)",
	 	too_long: "muito longo (deve ser menor que 100 caracteres)"}
	validates :categoria, presence: { message: "nao especificada" }
	validates :texto, presence: { message: "em branco" }, length: { minimum: 2, too_short: "muito curto (deve ser maior que 2 caracteres)" }
	validates :user_id, presence: { message: "nao especificado"}

end
