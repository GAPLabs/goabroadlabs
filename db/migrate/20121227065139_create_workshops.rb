class CreateWorkshops < ActiveRecord::Migration
    def change
        create_table :workshops do |t|

            t.timestamps
        end
    end
end
