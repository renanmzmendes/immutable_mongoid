if Rails.env.development? or Rails.env.test?
  Mongoid.load!(File.expand_path('mongoid.yml', './config'))
else
  Mongoid.load!(File.expand_path('mongoid.deploy.yml', './config'))
end

# rubocop:disable all
module BSON
  class ObjectId
    alias_method :to_json, :to_s
    alias_method :as_json, :to_s
  end
end

module Mongoid
  module Document
    def serializable_hash(options = nil)
      h = super(options)
      h['id'] = h.delete('_id') if(h.has_key?('_id'))
      h
    end
  end
end
# rubocop:enable all

Mongoid.raise_not_found_error = false
