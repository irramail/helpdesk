class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text :text
      t.references :project, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.boolean :closed
      t.datetime :closed_at
      t.integer :status
      t.string :link

      t.timestamps null: false
    end
  end
end
