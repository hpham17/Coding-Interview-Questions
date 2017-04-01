class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :schedule, index: true, foreign_key: true
      t.string :event_type 
      t.datetime :start_time
      t.datetime :end_time
      t.string :food
      t.string :location

      t.timestamps null: false
    end
  end
end
