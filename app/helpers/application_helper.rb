module ApplicationHelper

  # Return the full title of the page
  def full_title(page_title)
    base_title = "MBU Online"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def current_user
    remember_token = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
end