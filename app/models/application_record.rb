class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  MAX_FOLLOW_COUNT = 3
end
