
module Exporter

  def self.export_products
    FasterCSV.generate do |csv|
      csv << ["Name", "Sku", "Inventory", "Price", "Availablity", "Category"]
      Product.find(:all, :order => "name asc").each do |p|
        if p.variants.empty?
          csv << [p.name, p.sku, p.inventory, p.price, p.available, "#{p.categories.map(&:name).join(',')}" ]
        else
          p.variants.each do |v|
            name = p.name + "("
            v.product_option_selections.each_with_index do |s, index|
              name += "; " unless index == 0
              name += "#{s.product_option.name}:#{s.name}"
            end
            name += ")"
            csv << [name, v.sku, v.inventory, v.price, p.available, "#{p.categories.map(&:name).join(',')}" ]
          end
        end
      end
    end
  end
end
