# twitter-bootstrap-rails-cdn

Twitter Boostrap CDN support for Rails 3 and 4

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
= twitter_bootstrap_javascript_include_tag
= javascript_include_tag 'application' ...
```

and

```ruby
= twitter_bootstrap_stylesheet_link_tag
= stylesheet_link_tag 'application' ...
```

Note that valid CDN symbols are `:netdna`.

Now, it will generate the following on production:

```html
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script>
//<![CDATA[
typeof $().modal == 'function' || document.write(unescape('%3Cscript src="/javascripts/bootstrap-2.3.2.min.js">%3C/script>'))
//]]>
</script>
```

on development:

```html
<script src="/assets/bootstrap-2.3.2.js?body=1" type="text/javascript"></script>
```

If you want to check the production URL, you can pass `force: true` as an option.

```ruby
twitter_bootstrap_javascript_include_tag :netdna, force: true
twitter_bootstrap_stylesheet_link_tag :netdna, force: true
```
