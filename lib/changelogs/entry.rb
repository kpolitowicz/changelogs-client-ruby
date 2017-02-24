module Changelogs
  class Entry
    attr_accessor :event
    attr_accessor :changeset
    attr_accessor :account_id
    attr_accessor :user_id
    attr_accessor :user_type
    attr_accessor :logged_type
    attr_accessor :logged_id
    attr_accessor :logged_at

    def self.site
      Changelogs.api_host
    end

    def self.create(attrs = {})
      new(attrs)
    end

    def initialize(attrs = {})
      attrs ||= {}

      @event       = attrs[:event]
      @changeset   = attrs[:changeset]
      @account_id  = attrs[:account_id]
      @user_id     = attrs[:user_id]
      @user_type   = attrs[:user_type]
      @logged_type = attrs[:logged_type]
      @logged_id   = attrs[:logged_id]
      @logged_at   = attrs[:logged_at]
    end
  end
end
