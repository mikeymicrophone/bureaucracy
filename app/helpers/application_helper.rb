# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def login_stuff
    if current_user
      link_to(current_user.login, current_user) + ' ' + link_to('logout', logout_path)
    else
      link_to('login', login_path) + ' ' + link_to('sign up', signup_path)
    end
  end
end
