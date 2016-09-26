class CreateResultsAnswers < ActiveRecord::Migration
  def change
    create_table :results_answers do |t|
      t.references :result, index: true, foreign_key: true
      t.references :answer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
