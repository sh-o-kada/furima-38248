class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def previous
    Item.where('id < ?', id).order('id DESC').first
  end

  def next
    Item.where('id > ?', id).order('id ASC').first
  end
end
