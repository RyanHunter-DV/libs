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
	def record_file(file=nil)
		if file!=nil
			file_prefix="record_data-";
			@record_file = File.open(file_prefix+file+".txt","w");
		else
			if @record_file==nil
				puts("record_file not exists")
				return $stdout;
			end
			return @record_file;
		end
	end
end
