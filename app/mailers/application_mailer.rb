# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'info@wms.localhost'
  layout 'mailer'
end
