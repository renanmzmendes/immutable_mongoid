class User
  include ImmutableMongoid
  include Mongoid::Timestamps

  field :email
  field :name
end
