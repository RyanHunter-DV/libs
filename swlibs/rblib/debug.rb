class Debug ##{{{

    attr_accessor :enabled;
    attr :action;
    attr :log_file;

    def initialize _e ##{{{
        @enabled = _e;
        @action={:display=>true};
    end ##}}}

    # current support :log
    # :display is supported by default
    def action(name)
        @action[name] = true;
    end
    def >(msg) ##{{{
        puts '[DEBUG] '+msg if enabled && @action && @action.has_key?(:display);
        if enabled && @action && @action.has_key?(:log)
            @log_file.write("[DEBUG] #{msg}\n")
        end
    end ##}}}
    
end ##}}}
