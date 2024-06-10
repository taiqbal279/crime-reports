class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :lockable, :timeoutable, :trackable

  #
  # enum and constant
  #
  enum role: %w[support_executive financial_executive field_executive super_admin]
end
