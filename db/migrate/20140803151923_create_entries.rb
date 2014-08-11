class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :date
      t.string :urgency
      t.string :name
      t.string :email
      t.string :phase
      t.string :city
      t.string :time_avail
      t.boolean :remote_ok
      t.text :comments

      t.timestamps
    end
  end
end
