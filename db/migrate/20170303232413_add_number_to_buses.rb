class AddNumberToBuses < ActiveRecord::Migration[5.0]
  def change
    add_column :buses, :number, :integer
  end
end
