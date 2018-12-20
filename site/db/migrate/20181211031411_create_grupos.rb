class CreateGrupos < ActiveRecord::Migration[5.1]
	def change
		create_table :grupos do |t|
			t.string :nome
			t.text :descricao

			t.timestamps
		end

		create_table :grupos_users, id: false do |t|
			t.references :user, foreign_key: {on_delete: :cascade}
			t.references :grupo, foreign_key: {on_delete: :cascade}
			t.timestamps
		end

		create_table :moderadores, id: false do |t|
			t.references :user, foreign_key: {on_delete: :cascade}
			t.references :grupo, foreign_key: {on_delete: :cascade}
			t.timestamps
		end

		create_table :solicitacoes_grupo, id: false do |t|
			t.references :user, foreign_key: {on_delete: :cascade}
			t.references :grupo, foreign_key: {on_delete: :cascade}
			t.timestamps
		end

	end
end
