require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Pocket < OmniAuth::Strategies::OAuth2
      option :name, 'pocket'

      option :provider_ignores_state, true

      option :client_options, {
        :site => 'https://getpocket.com',
        :request_url => '/v3/oauth/request',
        :authorize_url => '/auth/authorize',
        :token_url => '/v3/oauth/authorize'
      }

      uid { raw_info['username'] }

      info do
        {
          :name     => raw_info['username'],
          :nickname => raw_info['username']
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def raw_info
        access_token.params
      end

      def request_phase
        redirect client.authorize_url({:request_token => build_request_token, :redirect_uri => callback_url})
      end

      def build_request_token
        response = client.request(:post, client.options[:request_url], {
          :headers =>  {'Content-Type' => 'application/x-www-form-urlencoded'},
          :body => {:consumer_key => options.client_id, :redirect_uri => callback_url}
        })
        session['omniauth.pocket.token'] = response.parsed['code']
      end

      def build_access_token
        client.get_token({:consumer_key => options.client_id, :code => session.delete('omniauth.pocket.token')})
      end

    end
  end
end
