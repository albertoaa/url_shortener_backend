class AddTimesAccessedToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :times_accessed, :integer, default: 1
  end
end
