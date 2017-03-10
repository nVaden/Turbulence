class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :subject
      t.string :channel
      t.references :user, index: true

      t.timestamps
    end
  end
end
