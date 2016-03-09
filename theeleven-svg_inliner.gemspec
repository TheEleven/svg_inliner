$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the_eleven/svg_inliner/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the_eleven-svg_inliner"
  s.version     = TheEleven::SvgInliner::VERSION
  s.authors     = ["Jørgen Sundt"]
  s.email       = ["jorgen@theeleven.co.uk"]
  s.homepage    = "https://github.com/jsundt/svg_inliner"
  s.summary     = "Grabs symbol tags from a external svg file and embeds them as inline svg icons in your views."
  s.description = "Sacrifices a bit of speed for a lot of flexibility. Easily add animated icons or icons with multiple layers of css styling. Inlining the svgs ensures the best browser support, removes load in flashing and gives you easy access to styling every icon seperately based on hover or other events."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", '>= 4.2'
  s.add_dependency "nokogiri", '~> 1.6'

end
