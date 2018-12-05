class CreatePerfilExternos < ActiveRecord::Migration[5.1]
  def change
    create_table :perfil_externos do |t|
      t.string :nome
      t.string :link
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
