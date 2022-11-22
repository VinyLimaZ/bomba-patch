class CreateImporters < ActiveRecord::Migration[7.0]
  def change
    create_table :importers do |t|
      t.integer :step, default: 0
      t.timestamps
    end
  end
end
