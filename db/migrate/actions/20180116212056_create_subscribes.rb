class CreateSubscribes < ActiveRecord::Migration[5.1]
    def change
        create_table :subscribes do |t|
            t.references :user, foreign_key: true
            t.integer :target_id, foreign_key: true

            t.timestamps
        end
    end
end
