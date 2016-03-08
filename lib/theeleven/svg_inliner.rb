require "theeleven/svg_inliner/version"
require "theeleven/svg_inliner/configuration"

ActiveSupport.on_load( :action_view ){ include Theeleven::SvgInliner }

module Theeleven
  module SvgInliner

    def svg_icon(icon, options = {})
      options = {
        class: Theeleven::SvgInliner.configure.class, #svg tag classes
        path:  Theeleven::SvgInliner.configure.path,  #path to svg file
        aria:  Theeleven::SvgInliner.configure.aria   #add accessiablity attributes
      }.merge(options)

      symbol = get_icon(icon, options[:path])
      options[:viewbox] = symbol.attr('viewbox')

      content_tag(:svg, set_svg_opts(symbol, options)) do
        symbol.children.to_html.html_safe
      end
    end


    private

    def get_file(file)
      Nokogiri::HTML(File.read(file))
    end

    def get_icon(icon, file) #read file with nokogiri and find the symbol
      doc = get_file(file)
      symbol = doc.css("symbol[id='" + icon + "']")

      if symbol.blank?
        symbol = get_file("#{Rails.root}/lib/theeleven/svg_inliner/missing.svg").css("symbol")
        puts "Couldn't find svg symbol: #{icon} at: #{file}! Check spelling and make sure there's a <symbol> with the id #{icon} in the specified file."
      end

      symbol
    end

    def set_svg_opts(symbol, options)
      svg_opts = {}

      if options[:aria]
        aria_title = symbol.css("title").text
        unless aria_title.blank?
          svg_opts = {
            aria: { label: aria_title },
            role: 'img'
          }
        else
          puts "Missing <title> in symbol. svg_inliner didn't add aria label to svg."
        end
      end

      {
        class: options[:class],
        viewBox: options[:viewbox]
      }.merge(svg_opts)
    end

  end
end
