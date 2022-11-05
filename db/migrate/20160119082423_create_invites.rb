class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :ticket, index: true, foreign_key: true
      t.string :key
      t.datetime :used_at
      t.datetime :expired_at
      t.string :ip
      t.string :email

      t.timestamps null: false
    end
  end
end
