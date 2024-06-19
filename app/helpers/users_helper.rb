module UsersHelper
  def address(user)
    user.other_infos['address'].except('geo').values.join(', ')
  end
end
