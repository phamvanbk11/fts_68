class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :question, index: true, foreign_key: true
      t.string :content
      t.boolean :is_correct, default: false

      t.timestamps null: false
    end
  end
end
