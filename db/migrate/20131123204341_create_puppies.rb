class CreatePuppies < ActiveRecord::Migration
  def change
    create_table :puppies do |t|
      t.string :path
      t.float :rating

      t.timestamps
    end
  end
end
