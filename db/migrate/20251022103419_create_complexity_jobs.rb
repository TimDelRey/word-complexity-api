class CreateComplexityJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :complexity_jobs do |t|
      t.integer :status, null: false
      t.jsonb :words, null: false
      t.jsonb :result
      t.text :error

      t.timestamps
    end
  end
end
