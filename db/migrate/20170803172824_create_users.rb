class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :email, unique: true
      t.date :indate
      t.text :password_digest
      t.string :jobtitle
      t.string :fotolink
      t.string :ischangepassword
      t.references :rol, foreign_key: true
      t.string :phone
      t.string :skillsandlevel
      t.string :statusflag
      t.string :country
      t.string :city

      t.timestamps
    end
  end
end
