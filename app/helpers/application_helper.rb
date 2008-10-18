# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_title
    @page_title ? "Ladder Challenge &raquo; #{@page_title}" : "Ladder Challenge"
  end
end
