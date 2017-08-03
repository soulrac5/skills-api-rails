class CreateSkillsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :skills_users do |t|
      t.references :user, foreign_key: true
      t.references :skill, foreign_key: true
      t.references :skills_level, foreign_key: true

      t.timestamps
    end
  end
end
