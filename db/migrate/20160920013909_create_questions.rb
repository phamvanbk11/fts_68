class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :subject, index: true, foreign_key: true
      t.string :content
      t.integer :question_type
      t.integer :state
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
