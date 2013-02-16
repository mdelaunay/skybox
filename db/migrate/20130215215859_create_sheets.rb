class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.integer :document_id
      t.string :paper

      t.timestamps
    end
  end
end
