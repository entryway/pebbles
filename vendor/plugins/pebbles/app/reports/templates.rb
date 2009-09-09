Ruport::Formatter::Template.create(:default) do |format|

  format.page = {
    :layout => :landscape
  }

  format.grouping = {
    :style => :separated
  }

  format.text = {
    :font_size => 16,
    :justification => :center
  }

  format.table = {
    :font_size         => 10,
    :heading_font_size => 10,
    :maximum_width     => 720,
    :width             => 720
  }

  format.column = {
    :alignment => :right
  }

  format.heading = {
    :alignment => :right,
    :bold      => true
  }

end