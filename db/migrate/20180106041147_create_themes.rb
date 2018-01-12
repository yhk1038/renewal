class CreateThemes < ActiveRecord::Migration[5.1]
    def change
        create_table :themes do |t|
            t.references :user, foreign_key: true    # 'group' has many users
            t.string :title,            null: false, default: 'Theme Title'
            t.string :background_img
            t.string :thumbnail_img

            t.timestamps
        end
    end
end
