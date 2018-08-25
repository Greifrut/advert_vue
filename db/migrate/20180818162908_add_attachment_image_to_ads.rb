# frozen_string_literal: true

class AddAttachmentImageToAds < ActiveRecord::Migration[5.2]
  def self.up
    change_table :ads do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :ads, :image
  end
end
