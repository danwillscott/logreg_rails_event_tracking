class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, index: true
      t.references :event, index: true
      t.timestamps
    end
  end
end
