# frozen_string_literal: true
module Hertz
  module Notifiable
    def self.included(base)
      base.class_eval <<-'RUBY'
        has_many :notifications,
          class_name: 'Hertz::Notification',
          as: :receiver,
          inverse_of: :receiver,
          dependent: :destroy

        def notify(notification_or_klass, meta = {})
          notification = if notification_or_klass.is_a?(Class)
            notification_or_klass.new(meta: meta)
          else
            notification_or_klass
          end

          notification.receiver = self

          notifications << notification
        end
      RUBY
    end
  end
end
