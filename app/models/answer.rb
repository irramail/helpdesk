class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  has_many :attachments, as: :attachable, dependent: :destroy

  accepts_nested_attributes_for :attachments, allow_destroy: true
end
