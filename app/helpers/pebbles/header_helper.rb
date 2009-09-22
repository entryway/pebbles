module Pebbles::HeaderHelper

  # the page title for each individual page
  def title(page_title)
    content_for(:title) { page_title }
  end
 
  # meta keywards for each page
  def meta_description(description)
    content_for(:meta_description) { description }
  end
 
  # meta keywards for each page
  def meta_keywords(keywords)
    content_for(:meta_keywords) { keywords }
  end
 
  # stylesheet include tag
  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  # stylesheet include tag
  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end
  
end
