class Project < ActiveRecord::Base
  has_many :projects_users
  has_many :users, through: :projects_users
  has_many :tickets

  validates :user_ids, length: { minimum: 1 }, on: [:update]
end
