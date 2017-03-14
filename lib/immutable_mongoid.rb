require 'active_support'
require 'active_support/core_ext'
require 'mongoid'

module ImmutableMongoid
  extend ActiveSupport::Concern
  include Mongoid::Document

  included do
    field :_active
    field :_immutable_id

    default_scope -> { where(_active: true) }

    before_create :set_immutable_id
    before_create :set_active

    before_update :set_old_attributes
    after_update :create_active_object

    def old_attributes
      @changed_attributes ||= {}
    end

    def new_attributes
      @new_attributes ||= {}
    end

    def reload
      self.class.find(self._immutable_id)
    end

    def self.find ident
      find_by(_immutable_id: ident)
    end
  end

  def set_immutable_id
    self._immutable_id ||= generate_immutable_id
  end

  def set_active
    self._active = true
  end

  def set_old_attributes
    self.changes.each do |key, value|
      # stores the old and new values
      old_attributes[key] = value[0]
      new_attributes[key] = value[1]
      self.send("#{key}=", value[0])
    end

    self._active = false
  end

  def create_active_object
    self.class.create(attributes.except('_id', '_created_at').merge new_attributes)
  end

  private

  def generate_immutable_id
    # TODO: Change this in order to generate
    # a more appropriate id format
    SecureRandom.hex
  end

end
