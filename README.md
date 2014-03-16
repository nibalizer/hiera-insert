hiera_insert
============


This module provides an inverse functionality to the hiera() function.

Rather than look up keys, this module provides functions to insert data into the variable databuckets from puppet.


Objective
=========

Inter node communication in Puppet is hard. There are some hacks available and the best supported way to to it is through exported resources. But if the thing you are trying to manage is not well modeled by types and providers, things get difficult. This effort, which is experimental, aims to allow arbitrary strings and possibly other data types to be set and read between Puppet nodes.


Example
=======


```puppet
redis_insert('loghost', $::fqdn)
$loghost = hiera('loghost')

notify { $loghost: }
```


In this example, the host exports its fqdn to the 'loghost' hiera key, then pulls it back out of hiera and creates a notify resource with it.




Longer example
==============


```puppet
node 'nodea' {

  redis_insert('loghost', $::fqdn)

  class { 'syslog::server': }

}

node 'nodeb' {

  class { 'syslog::client':
    server => hiera('loghost'),
  }

}
```

Here the logserver node exports its fqdn as a string into the loghost variable. The other node, which uses the syslog client picks up that key from hiera and uses it, presumably in a template for syslog.conf. This has the end result of inter-node communication. This also means that the nodeb node will fail every puppet run, essentially doing nothing, until the hiera key is put in place by nodea. This means we have guaranteed order of execution.



Functions
=========


redis_insert
------------

Insert a key/value pair into a redis database.

This is the opposite of a hiera lookup. Keys can be put into hiera using this. 

By default all keys are made under the 'redis:' namespace but this can be
controlled with the third argument.

Example:

    redis_insert('logserver', $::fqdn)

    redis_insert('logserver', $::fqdn, 'common')



Caveats
=======

The redis hiera backend is required right now. I hope to soon (or perhaps with community support) add support for other backends such as postgres. The redis hiera backend looks for keys of the type 'hierarchy:keyname' so for each element in the hierarchy it searches for a keyname. I have set the 'redis' hierarchy in my hiera.yaml and configured redis_insert() to use 'redis:' as the default prefix for inserting into hiera. You can specify a different prefix by giving it as a third argument to hiera_insert.
