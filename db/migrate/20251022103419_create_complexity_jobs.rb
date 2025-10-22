class CreateComplexityJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :complexity_jobs do |t|
      t.integer :status
      t.jsonb :words
      t.jsonb :result
      t.string :error
      t.string :text

      t.timestamps
    end
  end
end
