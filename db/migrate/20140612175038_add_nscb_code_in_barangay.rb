class AddNscbCodeInBarangay < ActiveRecord::Migration
  def change
    add_column :barangays, :nscb_code, :string
  end
end
