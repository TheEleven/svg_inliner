# The Eleven's SVG Inliner
Grabs symbol tags from external svg files and embed them as inline svg icons in your document.

Sacrifices a bit of speed for a lot of flexibility. Easily add animated icons or icons with multiple layers of css styling. Inlining the svgs ensures the best browser support, removes load in flashing and gives you easy access to styling every icon seperately based on hover or other events.


### Installation
```ruby
gem 'theeleven-svg_inliner'
```
Add line above to gemfile and execute: $ bundle


### Creating the SVG sprite
Setup the initial SVG sprite for your project. The inliner looks for symbols with id's, and appends the viewbox and the content of the symbol to a new svg content_tag in your view.

I'll add a few starter templates here later...

Save the svg sprite as iconset.svg and place it in app/assets/images/

```html
<svg xmlns="http://www.w3.org/2000/svg">
    <symbol id="social__twitter" viewBox="0 0 50 50">
        <title>Twitter</title>
        <path etc... >
    </symbol>
    <symbol id="social__facebook" viewBox="0 0 50 50">
        <title>Facebook</title>
        <path etc... >
    </symbol>
</svg>
```


### Using the svg_icon helper
The svg_icon helper requires a symbol id and accepts a few options
```ruby
svg_icon('social__email') #Add <symbol id="social__email"> from default path

svg_icon('app__settings', class:'icon--big') #Add change the class of <svg>

svg_icon('app__menu', path: asset_path('animated_icons.svg')) #Add a symbol from a non default svg file
```


### Setting defaults
By default the helper will look for iconset.svg in app/assets/images, you can change the default by adding svg_inliner.rb to config/initialisers/theeleven/
```ruby
Theeleven::SvgInliner.config = (Theeleven::SvgInliner.config || {}).merge({
  class: 'icon', #Default class for <svg> tags
  path: "#{Rails.root}/app/assets/images/iconset.svg", # path to default file
  aria: true #Add accessiablity attributes to svg file
})
```


### Further reading
I'm gonna add some useful links about svgs etc...

### Optimazing svgs
Applications export lots of unneccessary stuff I'm gonna add some optimization tools here...
