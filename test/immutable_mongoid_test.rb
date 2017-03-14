require 'test_helper'

class ImmutableMongoid::Test < ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods

  def setup
    DatabaseCleaner.clean
  end

  test "truth" do
    assert_kind_of Module, ImmutableMongoid
  end

  test "document creation" do
    user = build(:user)
    user.save

    assert_not_nil User.find(user._object_id)
    assert_not_equal user._id, user._object_id
  end

  test "document update" do
    old_user = create(:user)
    old_email = old_user.email
    old_user.email = old_user.email + '.new'

    old_user.save

    # assert that there are really two records
    # in the database, but there is only one
    # visible using the default scope
    assert_equal 2, User.unscoped.all.size
    assert_equal 1, User.all.size

    user = User.find_by(_object_id: old_user._object_id)

    assert_not_nil user
    assert user._active
    assert_not_equal user._id, old_user._id
    assert_equal user.name, old_user.name
    assert_equal user.email, old_user.email + '.new'
  end
end
