require "svg_inliner/version"
require "svg_inliner/configuration"

ActiveSupport.on_load( :action_view ){ include SvgInliner }

module SvgInliner
  class Engine < ::Rails::Engine
  end

  $INLINER_PATH = File.expand_path(File.dirname(__FILE__))

  def svg_icon(icon, options = {})
    options = SvgInliner.defaultOptions.merge(options)

    if options[:inline]
      file = "#{Rails.root}" + options[:path] + options[:file]

      symbol = get_icon(icon, file)
      options[:viewbox] = symbol.attr('viewbox')

      content_tag(:svg, set_svg_opts(symbol, options)) do
        symbol.children.to_html.html_safe
      end
    else
      file = asset_path options[:file] + '#' + icon

      content_tag(:svg, class: options[:class]) do
        content_tag(:use, nil, :"xlink:href" => file)
      end
    end
  end

  def each_svg_icon(options = {})
    options = SvgInliner.defaultOptions.merge(options)
    file = "#{Rails.root}" + options[:path] + options[:file]
    symbols = ''.html_safe

    get_file(file).css('symbol').each do |symbol|
      options[:viewbox] = symbol.attr('viewbox')
      symbols << content_tag(:svg, set_svg_opts(symbol, options)) do
        symbol.children.to_html.html_safe
      end
    end

    symbols.html_safe
  end

  private

  def get_file(file)
    Nokogiri::HTML(File.read(file))
  end

  def get_icon(icon, file) #read file with nokogiri and find the symbol
    doc = get_file(file)
    symbol = doc.css("symbol[id='" + icon + "']")

    if symbol.blank?
      missing_doc = $INLINER_PATH + "/svg_inliner/missing.svg"
      symbol = get_file(missing_doc).css("symbol")
      Rails.logger.error "Missing symbol"
      Rails.logger.error "Couldn't find svg symbol: '#{icon}' in: '#{file}'!"
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
          role: options[:role]
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
