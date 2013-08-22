module ApplicationHelper

  def full_page_title( title )
    base_title = "Sample App"
    
    if title.empty?
      base_title
    else
      "#{base_title} | #{title}"
    end
  end
end
