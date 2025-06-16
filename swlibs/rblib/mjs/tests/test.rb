#! /usr/bin/env ruby


require_relative '../MultJobSystem'
require_relative '../MjsCommand'

ENV['DEBUG_MODE'] = 'true';
MultJobSystem.run(10);

job=MjsCommand.new(:external,self){"echo 'Hello, World! command 1';sleep 5 ;"};
p=MultJobSystem.dispatch(job);
job2=MjsCommand.new(:external,self){"echo 'Hello, World! command 2';sleep 2 ;"};
p2=MultJobSystem.dispatch(job2);

sleep(10);


exit 0;