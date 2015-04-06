# Testing

Testing is off course great, and well practised in the ruby community.
Good tests exists in the parts where functionality is clear: Parsing and binary generation.

But it is difficult to write tests when you don't know what the functionality is.
Also TDD does not really help as it assumes you know what you're doing.

I used minitest / test-unit as the framewok, just because it is lighter and thus when the
time comes to move to salama, less work.

### All

''''
  ruby test/test_all.rb
''''

### sof

''''
  ruby test/test_sof.rb
''''

### vm

As this is all quite new, i tend to test only when i know that the functionality will stay that way.
Otherwise it's just too much effort to rewrite and rewrite the tests.

There used to be better tests, but rewrites bring fluctuation, so poke around and make suggestion :-) 
