# encoding: utf-8
class Note
  include Mongoid::Document
  # jinda begin
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  field :title, :type => String
  field :body, :type => String
  belongs_to :user
  validates :title, :user_id, :body, presence: true
  # jinda end
end
