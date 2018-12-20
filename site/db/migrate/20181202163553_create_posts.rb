class CreatePosts < ActiveRecord::Migration[5.1]
	def change
		create_table :posts do |t|
			t.string :titulo
			t.string :categoria
			t.text :texto
			t.column :e_de_grupo, :boolean, default: false
			t.references :user, foreign_key: true

			t.timestamps
		end


		create_table :posts_de_grupos do |t|
			t.references :post, foreign_key: {on_delete: :cascade}
			t.references :grupo, foreign_key: {on_delete: :cascade}
			t.timestamps
		end


	end
end
