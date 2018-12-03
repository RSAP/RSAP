class AddAttachmentImagemToPosts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :posts do |t|
      t.attachment :imagem
    end
  end

  def self.down
    remove_attachment :posts, :imagem
  end
end
