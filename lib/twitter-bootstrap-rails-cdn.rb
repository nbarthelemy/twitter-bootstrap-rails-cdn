require 'twitter-bootstrap-rails-cdn/version'

module TwitterBootstrap::Rails::Cdn
  module ActionViewExtensions
    OFFLINE = ( Rails.env.development? or Rails.env.test? )
    DEFAULT_HOST = :netdna
    BOOTSTRAP_VERSIONS = [ '2.3.2' ]

    def twitter_bootstrap_url(type, host, options = {})
      version  = options.delete(:version) || BOOTSTRAP_VERSIONS.first

      ext = ''
      if type == :css
        ext << '-combined' unless options.delete(:responsive) == false
      end
      ext << '.min' unless options.delete(:compressed) == false

      {
        :netdna => "//netdna.bootstrapcdn.com/twitter-bootstrap/#{version}/#{type}/bootstrap#{ext}.#{type}",
        :local  => "bootstrap-#{version}#{ext}"
      }[host]
    end

    def twitter_bootstrap_javascript_url(host = DEFAULT_HOST, options = {})
      twitter_bootstrap_url(:js, host, options)
    end

    def twitter_bootstrap_stylesheet_url(host = DEFAULT_HOST, options = {})
      twitter_bootstrap_url(:css, host, options)
    end

    def twitter_bootstrap_javascript_include_tag(host, options = {}, html_options = {})
      local = twitter_bootstrap_javascript_url(:local, options)

      if OFFLINE and !options.delete(:force)
        javascript_include_tag(local, html_options)
      else
        [ 
          javascript_include_tag(twitter_bootstrap_javascript_url(host, options), html_options),
          javascript_tag("typeof $().modal == 'function' "+
            "|| document.write(unescape('#{javascript_include_tag(local, html_options).gsub('<','%3C')}'))")
        ].join("\n").html_safe
      end
    end

    def twitter_bootstrap_stylesheet_include_tag(host, options = {}, html_options = {})
      local = twitter_bootstrap_stylesheet_url(:local, options)

      if OFFLINE and !options.delete(:force)
        stylesheet_link_tag(local, options)
      else
        [ stylesheet_link_tag(twitter_bootstrap_stylesheet_url(host, options), html_options),
          javascript_tag("$(function(){ $('body').css('color') === 'rgb(51, 51, 51)' "+
            "|| $('head').prepend('#{stylesheet_link_tag(local, html_options)}'); });")
        ].join("\n").html_safe
      end
    end
  end

  class Railtie < Rails::Railtie
    initializer 'twitter_bootstrap_rails_cdn.action_view' do |app|
      ActiveSupport.on_load(:action_view) do
        include TwitterBootstrap::Rails::Cdn::ActionViewExtensions
      end
    end
  end
end
