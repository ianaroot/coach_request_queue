class AddParamsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :params, :text
  end
end
