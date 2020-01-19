require 'active_support/all'
require 'io/console'

class CLIKeyFetcher
  def initialize(cli_description = "API Key", secret_key_required = false, env_key = nil, secret_key_env_key = nil)
    @secret_key_required = secret_key_required
    @cli_description = cli_description

    if(env_key && ENV[env_key])
      @key = ENV[env_key]
      split_key_and_secret
    end

    if(secret_key_required && secret_key_env_key && ENV[secret_key_env_key])
      @secret_key = ENV[secret_key_env_key]
    end
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

  def split_key_and_secret
    if(@key.match(/,/) && secret_key_required)
      split = @key.split(/,/)

      @key = split[0]
      @secret_key = split[1]
    end
  end

  def fetch_keys_if_nil
    while(@key.blank?)
      STDOUT.puts "#{cli_description} cannot be blank" unless @key.nil?
      STDOUT.puts "#{cli_description}:"
      @key = STDIN.noecho(&:gets).strip
    end

    split_key_and_secret

    while(@secret_key_required && @secret_key.blank?)
      STDOUT.puts "#{cli_description} secret cannot be blank" unless @secret_key.nil?
      STDOUT.puts "#{cli_description} secret:"
      @secret_key = STDIN.noecho(&:gets).strip
    end
  end

  attr_reader :secret_key_required, :cli_description
end
