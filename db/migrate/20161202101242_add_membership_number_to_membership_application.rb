class AddMembershipNumberToMembershipApplication < ActiveRecord::Migration[5.0]
  def change
    add_column :membership_applications, :membership_number, :string, index: true
  end
end
