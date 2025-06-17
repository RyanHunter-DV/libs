class Printer ##{{{

    attr_accessor :verbosity, :severity;
    attr :action;
    attr :log_file;

    def initialize _v=5, _s=:DEBUG ##{{{
        @verbosity = _v;
        @severity = _s;
        @action={:display=>true};
    end ##}}}

    # current support :log
    # :display is supported by default
    def action(name)
        @action[name] = true;
    end
    def >(msg, v=0) ##{{{
        # for debug, the verbosity must >= 5
        v+=5 if @severity == :DEBUG;
		caller_info = caller(1).first
		message = "[#{caller_info}] #{msg}"
        puts "[#{@severity}] "+message if v < @verbosity && @action && @action.has_key?(:display);
        if v < @verbosity && @action && @action.has_key?(:log)
            @log_file.write("[#{@severity}] #{message}\n")
        end
    end ##}}}
end ##}}}
