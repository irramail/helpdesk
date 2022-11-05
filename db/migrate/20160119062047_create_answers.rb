class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text
      t.references :user, index: true, foreign_key: true, null: false
      t.references :ticket, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
