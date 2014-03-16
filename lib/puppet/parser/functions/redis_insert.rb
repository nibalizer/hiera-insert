module Puppet::Parser::Functions
  newfunction(:redis_insert, :doc => <<-'ENDHEREDOC') do |args|

    Insert a key/value pair into a redis database.

    This is the opposite of a hiera lookup. Keys can be put into hiera using this. 

    By default all keys are made under the 'redis:' namespace but this can be
    controlled with the third argument.

    Example:

    redis_insert('logserver', $::fqdn)

    redis_insert('logserver', $::fqdn, 'common')

    ENDHEREDOC

    #raise(Puppet::ParseError, "redis_insert(): Wrong number of arguments " +
    #  "given (#{args.size} for 2)") if ( 1 >= args.size >= 3 )

    require 'redis'

    redis = Redis.new

    key = args[0]
    value = args[1]
    if args[2]
      prefix = args[2]
    else
      prefix = 'redis'
    end

    redis.set(prefix + ':' + key, value)

  end

end
