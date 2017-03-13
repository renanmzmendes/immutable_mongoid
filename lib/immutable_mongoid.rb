require 'active_support'
require 'active_support/core_ext'
require 'mongoid'

module ImmutableMongoid
  extend ActiveSupport::Concern
  include Mongoid::Document

  included do
    field :_active
    field :_object_id

    default_scope -> { where(_active: true) }

    before_create :set_object_id
    before_create :set_active

    before_update :set_old_attributes
    after_update :create_active_object

    alias_method :id, :_object_id

    def old_attributes
      @changed_attributes ||= {}
    end

    def new_attributes
      @new_attributes ||= {}
    end

    def reload
      self.class.find(self._object_id)
    end

    def self.find ident
      self.find_by(_object_id: ident)
    end
  end

  def set_object_id
    self._object_id ||= generate_object_id
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
    self.class.create(new_attributes.merge(_object_id: self._object_id))
  end

  private

  def generate_object_id
    # TODO: Change this in order to generate
    # a more appropriate id format
    SecureRandom.hex
  end

end
