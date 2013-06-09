class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.string :url
      t.string :email
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :enabled

      t.timestamps
    end
  end
end
