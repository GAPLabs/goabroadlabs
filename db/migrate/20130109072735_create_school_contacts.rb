class CreateSchoolContacts < ActiveRecord::Migration
  def change
    create_table :school_contacts do |t|
      t.string :email

      t.timestamps
    end
  end
end
