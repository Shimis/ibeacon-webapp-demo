class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
			t.integer :customer_id
      t.datetime :enter_time
      t.datetime :exit_time

      t.timestamps
    end
  end
end
