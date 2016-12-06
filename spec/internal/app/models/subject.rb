class Subject < ActiveRecord::Base
  has_many :videos, as: :subject
end
