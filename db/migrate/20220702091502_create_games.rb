class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :uuid
      t.references :word

      t.timestamps
    end
  end
end
