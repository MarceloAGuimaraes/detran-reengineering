class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :content
      t.date :date
      t.string :erros, default: nil
      t.timestamps
    end
  end
end
