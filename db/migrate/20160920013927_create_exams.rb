class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.references :subject, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :state
      t.integer :spent_time, default: 0
      t.boolean :is_finished, default: false
      t.datetime :start_tested_at

      t.timestamps null: false
    end
  end
end
