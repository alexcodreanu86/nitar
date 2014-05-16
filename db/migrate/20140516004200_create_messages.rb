class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :sender_email
      t.string :subject
      t.text :content
      t.boolean :was_answered, default: false

      t.timestamps
    end
  end
end
