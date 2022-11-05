class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :category
  has_many :answers

  has_many :attachments, as: :attachable, dependent: :destroy
  accepts_nested_attributes_for :attachments, allow_destroy: true

  STATUS= %i[open closed]

  #default_scope { order("created_at asc") }
end
