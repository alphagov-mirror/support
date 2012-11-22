require 'tableless_model'
require 'with_requester'
require 'with_time_constraint'
require 'with_inside_government'

class NewFeatureRequest < TablelessModel
  include WithRequester
  include WithTimeConstraint
  include WithInsideGovernment

  attr_accessor :user_need, :url_of_example
  validates_presence_of :user_need
end