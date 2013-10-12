# twitter-bootstrap-rails-cdn

Twitter Boostrap CDN support for Rails 3 and 4

*See below for details on using the new 2.3.2 version of bootstrap.*

Serving Bootstrap from a publicly available [CDN](http://en.wikipedia.org/wiki/Content_Delivery_Network) has clear benefits:

* **Speed**: Users will be able to download Bootstrap from the closest physical location.
* **Caching**: CDN is used so widely that potentially your users may not need to download Bootstrap at all.
* **Parallelism**: Browsers have a limitation on how many connections can be made to a single host. Using CDN for Bootstrap offloads a big one.

## Features

This gem offers the following features:

* Supports netdna CDN, but other CDNs could be added
* Bootstrap version is defaulted to the most recent version, but other versions can be specified.
* Automatically fallback to local copy of Bootstrap when:
  * You're on a development environment, so that you can work offline.
  * The CDN is down or unreachable.

On top of that, if you're using asset pipeline, you may have noticed that the major chunks of the code in combined `application.js` is Bootstrap. Implications of externalizing Bootstrap from `application.js` are:

* Updating your JS code won't evict the entire cache in browsers.
  * Cached Bootstrap in the client browsers will survive deployments.
  * Your code changes more often than Bootstrap upgrades, right?
* `rake assets:precompile` will run faster and use less memory.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'twitter-bootstrap-rails-cdn'
```

## Usage

This gem adds a few methods methods `twitter_bootstrap_javascript_include_tag`, `twitter_bootstrap_javascript_url`,
`twitter_bootstrap_stylesheet_link_tag` and `twitter_bootstrap_stylesheet_url`.

If you're using asset pipeline with Rails 3.1+ or 4.+,

- Remove any references to bootstrap from `application.js`.

Then in layout:

```ruby
= twitter_bootstrap_stylesheet_link_tag :netdna
= stylesheet_link_tag 'application' ...
```

```ruby
= twitter_bootstrap_javascript_include_tag :netdna
= javascript_include_tag 'application' ...
```

Note that currently, the only valid CDN symbol is `:netdna`, and this must be passed to tag methods.

Now, it will generate the following on production:

```html
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" media="screen" rel="stylesheet" />
```

```html
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script>
//<![CDATA[
typeof $().modal == 'function' || document.write(unescape('%3Cscript src="/javascripts/bootstrap-3.0.0.min.js">%3C/script>'))
//]]>
</script>
```

on development:

```html
<script src="/assets/bootstrap-3.0.0.css?body=1" type="text/javascript"></script>
```

```html
<script src="/assets/bootstrap-3.0.0.js?body=1" type="text/javascript"></script>
```

If you want to check the production URL, you can pass `force: true` as an option.

```ruby
twitter_bootstrap_stylesheet_link_tag :netdna, force: true
twitter_bootstrap_javascript_include_tag :netdna, force: true
```

The default Bootstrap version is now 3.0.0. If you want to use 2.3.2 just set the version in the options and force the use of a CDN in development.

```ruby
twitter_bootstrap_stylesheet_link_tag :netdna, force: true, version: '2.3.2'
twitter_bootstrap_javascript_include_tag :netdna, force: true, version: '2.3.2'
```

## License

Copyright (c) 201 Nicholas Barthelemy

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
