hiera_insert
============


This module provides an inverse functionality to the hiera() function.

Rather than look up keys, this module provides functions to insert data into the variable databuckets from puppet.


Objective
=========

Inter node communication in Puppet is hard. There are some hacks available and the best supported way to to it is through exported resources. But if the thing you are trying to manage is not well modeled by types and providers, things get difficult. This effort, which is experimental, aims to allow arbitrary strings and possibly other data types to be set and read between Puppet nodes.


Example
=======





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




