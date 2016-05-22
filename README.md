# The Eleven's SVG Inliner
Grabs svg symbols from a svg file and embeds them as inline svg in your views.

Sacrifice a bit of speed for a lot of flexibility. Easily add animated icons or icons with multiple layers of css styling. Inlining the svgs ensures the best browser support, removes load flashing and gives you easy access to style every icon separately based on hover or other events.


### Installation
```ruby
gem 'svg_inliner'
```
Add line above to gemfile and execute: $ bundle


### Creating the SVG sprite
Setup the initial SVG sprite for your project. The inliner looks for symbols with id's, and appends the viewbox and the content of the symbol to a new svg content_tag in your view.

I'll add a few starter templates here later...

Save the svg sprite as iconset.svg and place it in lib/assets/images/

```html
<svg xmlns="http://www.w3.org/2000/svg">
  <symbol id="social__twitter" viewBox="0 0 50 50">
    <title>Twitter</title>
    <path etc goes here >
  </symbol>
  <symbol id="social__facebook" viewBox="0 0 50 50">
    <title>Facebook</title>
    <path etc goes here >
  </symbol>
</svg>
```


### Using the svg_icon helper
The svg_icon helper requires a symbol id and accepts a few options
```ruby
svg_icon('social__email') #Grabs 'social__email' icon from default path

svg_icon('app__settings', class:'icon--big') #change the class of <svg>

svg_icon('app__menu', file: 'animated_icons.svg') #Add a symbol from another svg file
```
output:
```html
<svg class="icon" viewBox="0 0 50 50" role="img" aria-label="Email icon">
  <title>Email Icon</title>
  <path etc goes here >
</svg>
```


### Setting defaults
By default the helper will look for iconset.svg in 'lib/assets/images', you can change the default by adding svg_inliner.rb to 'config/initializers/'

Here are the defaults:
```ruby
SvgInliner.configure do |config|
  config.css_class = 'icon'
  config.path = "/lib/assets/images/"
  config.file = "iconset.svg"
  config.inline = true
  config.role = 'img'
  config.aria = true
end
```


### Using JS inlining for none critical icons
Inlining everything on the server can be a bit expensive. Luckily we can use jonathantneal's svg4everybody script to inline every none critical piece of svg after the document is ready.

Read https://github.com/jonathantneal/svg4everybody for documentation for svg4everybody

Add this to your application.js file to enable svg4everybody:
```javascript
//= require svg_inliner/svg4everybody

svg4everybody({
  fallback: function (src, svg, use) {
    return 'fallback.png'; // always return fallback.png
  },
  nosvg: false, // shiv <svg> and <use> elements and use image fallbacks (requires legacy version of svg4everybody)
  polyfill: true // polyfill <use> elements for External Content
});
end
```


### Further reading
I'm gonna add some useful links about svgs etc...

### Optimazing svgs
Applications export lots of unnecessary stuff I'm gonna add some optimization tools here...
