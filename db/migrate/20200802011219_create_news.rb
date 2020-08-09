class CreateNews < ActiveRecord::Migration[6.0]
  def change
    create_table :news do |t|
      t.string :content
      t.date :date
      t.string :link
      t.string :log_error, default: nil
      t.timestamps
    end
  end
end
