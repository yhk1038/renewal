class CreateThemeGroups < ActiveRecord::Migration[5.1]
    def change
        create_table :theme_groups do |t|
            t.string :title
            t.string :description
            t.string :link

            t.timestamps
        end
    end
end

