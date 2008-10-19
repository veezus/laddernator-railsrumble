# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_title
    @page_title ? "LADDERNATOR &raquo; #{@page_title}" : "LADDERNATOR"
  end
  
  ## haml classes
  
  def viewing_current_class(record, record_to_match)
    'current' if !record.nil? and record == record_to_match
  end
  
end
