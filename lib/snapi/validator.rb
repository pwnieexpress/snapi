module Snapi

  # Helpful module to check strings against named Regexp patterns which
  # are stored in here.
  module Validator

    module_function :valid_input?, :validation_regex, :format_types, :valid_regex_format?

    # Core method of the module which attempts to check if a provided
    # string matches any of the regex's as identified by the key
    #
    # @params key, Symbol key which maps to one of the keys in the validation_regex method below
    # @params string, String to check
    # @returns Boolean, true if string checks out
    def valid_input?(key,string)
      raise InvalidFormatError unless valid_regex_format?(key)

      boolarray = validation_regex[key].map do |regxp|
        (string =~ regxp) == 0 ? true : false
      end

      return true if boolarray.include?(true)
      false
    end

    # A helper to get get the keys off the validation_regex hash
    #
    # @returns Array of symbols
    def format_types
      validation_regex.keys
    end

    # A helper to validate that the requested symbols is a valid
    # type of format we can check against
    #
    # @param format, Symbol to check
    # @returns Boolean, true if the requested format is in format_types array
    def valid_regex_format?(format)
      format_types.include?(format)
    end

    # A helper dictionary which returns and array of valid Regexp patterns
    # in exchange for a valid key
    #
    # @returns Hash, dictionary of symbols and Regexp arrays
    def validation_regex
      {
        :address             => [HOSTNAME_REGEX, DOMAIN_REGEX, IP_V4_REGEX, IP_V6_REGEX],
        :anything            => [/.*/],
        :bool                => [TRUEFALSE_REGEX],
        :command             => [SIMPLE_COMMAND_REGEX],
        :cron                => [CRON_REGEX],
        :gsm_adapter         => [ADAPTER_REGEX],
        :hostname            => [HOSTNAME_REGEX],
        :interface           => [INTERFACE_REGEX],
        :ip                  => [IP_V4_REGEX, IP_V6_REGEX],
        :ipv6                => [IP_V6_REGEX],
        :ipv4                => [IP_V4_REGEX],
        :mac                 => [MAC_REGEX],
        :snapi_function_name => [SNAPI_FUNCTION_NAME],
        :string              => [STRING_REGEX],
        :on_off              => [ON_OFF_REGEX],
        :port                => [PORT_REGEX],
        :uri                 => [URI_REGEX],
        :username            => [HOSTNAME_REGEX],
        :password            => [NUM_LETTERS_SP_CHARS]
      }
    end

    ############################################################################
    #  ______ _____ _   _ _____ _    ______
    #  | ___ \  ___| | | |  _  | |   |  _  \
    #  | |_/ / |__ | |_| | | | | |   | | | |
    #  | ___ \  __||  _  | | | | |   | | | |
    #  | |_/ / |___| | | \ \_/ / |___| |/ /
    #  \____/\____/\_| |_/\___/\_____/___( )
    #                                    |/
    #
    #   _____ _   _  _____  ______  ___ _____ _____ ___________ _   _  _____
    #  |_   _| | | ||  ___| | ___ \/ _ \_   _|_   _|  ___| ___ \ \ | |/  ___|
    #    | | | |_| || |__   | |_/ / /_\ \| |   | | | |__ | |_/ /  \| |\ `--.
    #    | | |  _  ||  __|  |  __/|  _  || |   | | |  __||    /| . ` | `--. \
    #    | | | | | || |___  | |   | | | || |   | | | |___| |\ \| |\  |/\__/ /
    #    \_/ \_| |_/\____/  \_|   \_| |_/\_/   \_/ \____/\_| \_\_| \_/\____/
    #
    #
    #
    # Note base on lib/shells/gsm.rb
    ADAPTER_REGEX = /^(unlocked_gsm|verizon_virgin_mobile|tmobile)$/
    #
    # Note set in lib/shells/scheduler.rb
    CRON_REGEX = /^(1_minute|5_minutes|15_minutes|60_minutes)$/
    #
    # Source:
    SIMPLE_COMMAND_REGEX = /^([a-zA-Z0-9\.\s\-\_\/\\\,\=]+)*$/i
    #
    # Source: RFC952, RFC1034
    HOSTNAME_REGEX = /^[a-z0-9-]{1,63}$/i
    #
    # Source: RFC952, RFC1034, does not take max length into account
    DOMAIN_REGEX = /^([a-z0-9-]{1,63}\.)*[a-z0-9-]{1,63}$/i
    #
    # validate the name for a function name
    SNAPI_FUNCTION_NAME = /[a-z0-9_]/
    #
    INTERFACE_REGEX = /^([a-z]+)+([0-9]+)+$/i
    #
    # IPV4 Source: http://answers.oreilly.com/topic/318-how-to-match-ipv4-addresses-with-regular-expressions/
    IP_V4_REGEX = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
    #
    # IPV6 Source: https://gist.github.com/294476
    IP_V6_REGEX = /^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$/
    #
    # Mac Source: http://www.ruby-forum.com/topic/139401
    MAC_REGEX = /^([0-9a-f]{2}[:-]){5}[0-9a-f]{2}$/i
    #
    # SIMPLE ON / OFF (CHECKBOXES)
    ON_OFF_REGEX = /^(on|off)$/i
    #
    # Source:
    STRING_REGEX = /^([a-zA-Z0-9\.\-\_]+)*$/i
    #
    # TRUE OR FALSE
    TRUEFALSE_REGEX = /^(true|false)$/i
    #
    # mmmmmmmm
    PORT_REGEX = /^(6[0-5][0-5][0-3][0-5]|6[0-4][0-9]{3}|[1-5][0-9]{4}|[1-9][0-9]{1,3}|[1-9])$/
    #
    NUM_LETTERS_SP_CHARS = /^[\w\[\]\!\@\#\$\%\^\&\*\(\)\{\}\:\;\<\>\+\-]*$/i
    #
    URI_REGEX = /https?:\/\/[\S]+/
  end
end
