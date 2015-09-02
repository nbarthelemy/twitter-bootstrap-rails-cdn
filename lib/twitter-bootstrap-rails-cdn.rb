require 'twitter-bootstrap-rails-cdn/engine' if ::Rails.version >= '3.1'
require 'twitter-bootstrap-rails-cdn/railtie'
require 'twitter-bootstrap-rails-cdn/version'

module TwitterBootstrap::Rails::Cdn
  module ActionViewExtensions
    OFFLINE = ( ::Rails.env.development? or ::Rails.env.test? )
    DEFAULT_HOST = :netdna
    BOOTSTRAP_VERSIONS = [ '3.3.5', '3.0.0', '2.3.2' ]

    def twitter_bootstrap_javascript_url(host = DEFAULT_HOST, options = {})
      twitter_bootstrap_url(:js, host, options)
    end

    def twitter_bootstrap_stylesheet_url(host = DEFAULT_HOST, options = {})
      twitter_bootstrap_url(:css, host, options)
    end

    def twitter_bootstrap_javascript_include_tag(host, options = {}, html_options = {})
      local = twitter_bootstrap_javascript_url(:local, options)

      if OFFLINE and !options[:force]
        javascript_include_tag(local, html_options)
      else
        [
          javascript_include_tag(twitter_bootstrap_javascript_url(host, options), html_options),
          javascript_tag("typeof $().modal == 'function' "+
            "|| document.write(unescape('#{javascript_include_tag(local, html_options).gsub('<','%3C')}'))")
        ].join("\n").html_safe
      end
    end

    def twitter_bootstrap_stylesheet_link_tag(host, options = {}, html_options = {})
      local = twitter_bootstrap_stylesheet_url(:local, options)

      if OFFLINE and !options[:force]
        stylesheet_link_tag(local, html_options)
      else
        stylesheet_link_tag(twitter_bootstrap_stylesheet_url(host, options), html_options)
      end
    end

  private

    def twitter_bootstrap_url(type, host, options = {})
      version  = options[:version] || BOOTSTRAP_VERSIONS.first
      is_v3 = !!version.match(/^3/)

      prefix = 'twitter-bootstrap'
      prefix = 'bootstrap' if is_v3

      ext = ''
      if type == :css && !is_v3
        ext << '-combined' unless options[:responsive] == false
      end
      ext << '.min' unless options[:compressed] == false

      {
        :netdna => "//netdna.bootstrapcdn.com/#{prefix}/#{version}/#{type}/bootstrap#{ext}.#{type}",
        :local  => "bootstrap-#{version}#{ext}"
      }[host]
    end
  end
end
