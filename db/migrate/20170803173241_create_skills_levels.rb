class CreateSkillsLevels < ActiveRecord::Migration[5.1]
  def change
    create_table :skills_levels do |t|
      t.string :name
      t.integer :code

      t.timestamps
    end
  end
end
