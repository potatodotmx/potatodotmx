# frozen_string_literal: true

# :nodoc:
class Download
  include ActiveModel::Model

  ARCHITECTURES =
    Set.new
       .add('x86_64')
       .freeze

  OPERATING_SYSTEMS =
    Set.new
       .add('linux')
       .add('darwin')
       .freeze

  attr_accessor :operating_system, :architecture

  def url
    "https://dowload/darwin/amd64"
  end
end
