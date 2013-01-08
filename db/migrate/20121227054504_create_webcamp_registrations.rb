class CreateWebcampRegistrations < ActiveRecord::Migration
    def change
        create_table :webcamp_registrations do |t|

            t.timestamps
        end
    end
end
