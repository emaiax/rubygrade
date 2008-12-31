class Registration < ActiveRecord::Base
belongs_to :course
belongs_to :student
belongs_to :attendance
named_scope :bycourse, lambda { |course| {:conditions => { :course_id => course, :presence => 0..1 } } }
end
