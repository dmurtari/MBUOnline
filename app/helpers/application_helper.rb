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
end
