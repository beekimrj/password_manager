class CreateEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :entries do |t|
      t.string :title
      t.string :username
      t.string :password
      t.string :url
      t.string :notes
      t.jsonb :data
      t.references :entryable, polymorphic: true, null: false
      t.timestamps
    end
  end
end
