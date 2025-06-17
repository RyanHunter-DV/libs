require_relative "CmdRecord"
class MjsCommand
	attr_accessor :exec, :type, :context;
	
	attr :record_file;
	def initialize(type = :external,ctx=nil, &block)
		@type = type
		if type==:internal
			@exec = block
		else
			@exec = self.instance_eval(&block);
		end
		@context = ctx if ctx!=nil;
	end


	# set record_file for process executing information
	def record_file(id=nil)
		if id!=nil
			@record_file = CmdRecord.new(id);
			@record_file.record_format('STATUS',1)
			@record_file.record_format('START_TIME',2)
			@record_file.record_format('FINISH_TIME',3)
			@record_file.record_format('COMMAND',4)
			#TODO, output and error may display in multiple lines,
			# so the line number given by 5 and 6 may not correct, will be enhanced later.
			@record_file.record_format('OUTPUT',5)
			@record_file.record_format('ERROR',6)
		else
			if @record_file==nil
				raise "record_file not initialized before using"
				#return $stdout;
			end
			return @record_file;
		end
	end
end
