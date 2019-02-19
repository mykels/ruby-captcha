# frozen_string_literal: true

class User
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def initialize(username = '', password = '')
    @username = username
    @password = password
  end

  attr_reader :username

  attr_reader :password

  def persisted?
    false
  end
end
