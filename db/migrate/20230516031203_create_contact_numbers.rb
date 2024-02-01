class CreateContactNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :contact_numbers do |t|
      t.references :contact, null: false, foreign_key: true
      t.integer :label
      t.string :number

      t.timestamps
    end
  end
end
