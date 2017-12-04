require 'active_support/all'
require 'io/console'

class CLIKeyFetcher
  def initialize(cli_description = "API Key", secret_key_required = false)
    @secret_key_required = secret_key_required
    @cli_description = cli_description
  end

  def key
    fetch_keys_if_nil
    @key
  end

  def secret_key
    fetch_keys_if_nil
    @secret_key
  end

  private

  def fetch_keys_if_nil
    while(@key.blank?)
      STDOUT.puts "#{cli_description} cannot be blank" unless @key.nil?
      STDOUT.puts cli_description
      @key = STDIN.noecho(&:gets).strip
    end

    if(@key.match(/,/) && secret_key_required)
      split = @key.split(/,/)

      @key = split[0]
      @secret_key = split[1]
    end

    while(@secret_key_required && @secret_key.blank?)
      STDOUT.puts "#{cli_description} secret cannot be blank" unless @secret_key.nil?
      STDOUT.puts "#{cli_description} secret:"
      @secret_key = STDIN.noecho(&:gets).strip
    end
  end

  attr_reader :secret_key_required, :cli_description
end
