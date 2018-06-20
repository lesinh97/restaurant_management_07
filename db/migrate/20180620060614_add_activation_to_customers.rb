class AddActivationToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :activation_digest, :string
    add_column :customers, :activated_at, :datetime
  end
end
