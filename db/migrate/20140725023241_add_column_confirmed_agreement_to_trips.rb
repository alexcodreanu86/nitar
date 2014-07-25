class AddColumnConfirmedAgreementToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :confirmed_agreement, :boolean
  end
end
