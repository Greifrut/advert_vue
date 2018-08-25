# frozen_string_literal: true

class AddUserIdToAds < ActiveRecord::Migration[5.2]
  def change
    add_reference :ads, :user, foreign_key: true
  end
end
