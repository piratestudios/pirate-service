# pirate-service

`pirate-service` is Ruby Gem that provides a base class for service objects in Pirate Studio's Ruby projects.

## Usage

``` ruby
require "pirate/service/base"

module Services
  module Accounts
    class FindAccountByApiKey < Pirate::Service::Base
      attr_reader :account
      attr_reader :api_key

      def call
        find_api_key
        set_account_from_api_key
        return account
      end

      private

      def find_api_key
        @api_key = ApiKey.find_by(token: attributes[:token])
        raise ApiKeyError.new(_("Invalid API key")) if @api_key.nil?
      end

      def set_account_from_api_key
        @account = api_key.account
      end

      class ApiKeyError < Pirate::Service::Error; end
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piratestudios/pirate-service.
