require_relative 'MjsCommand'
require 'open3'

class MjsProcess
	attr :job;
	attr :job_id;
	attr_accessor :output, :error;

	# :init, :running, :finished, :killed
	attr :status;

	def initialize(job)
		@job = job;
		@status = :init; 
		debug_log("Initializing MjsProcess with job: #{job.inspect}")
	end

	def record_time(type,time)
		#@time[type] = time;
		time_format = "RECORD_DATA-TIME: [#{type}] #{time}";
		#debug_log("Recording time format: #{time_format}")
		@job.record_file.write(time_format+"\n");
	end

	def record_output(output)
		debug_log("Recording output: #{output}")
		@output = output
	end

	def record_error(error)
		debug_log("Recording error: #{error}")
		@error = error
	end

	def record_command(type,command)
		if type == :external
			@job.record_file.write("RECORD_DATA-COMMAND: #{command}\n");
		else
			@job.record_file.write("RECORD_DATA-COMMAND: #{command}\n");
		end
	end

	def start
		debug_log("Starting process with status: #{@status}")
		@status = :running;
		job=@job;
		pid = fork do
			debug_log("Forked process with PID: #{Process.pid}")
			job.record_file(Process.pid.to_s);
			record_command(job.type,job.exec);
			if job.type == :external
				debug_log("(#{Process.pid}) Executing external job: #{job.exec}")
				record_time(:start,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
				stdout, stderr, status = Open3.capture3(job.exec)
				record_time(:finish,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
				record_output(stdout) if stdout
				record_error(stderr) if stderr
			else
				debug_log("Executing internal job: #{job.exec}")
				record_time(:start,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
				job.context.instance_eval(&job.exec);
				record_time(:finish,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
			end
			process_on_finish;
			debug_log("Process completed, exiting, job status: #{@status}")
			exit!
		end
		@job_id = pid;
		Process.detach(pid)
		debug_log("Process detached with job_id: #{@job_id}")
		@status = :finished;
		debug_log("Process finished, pid: #{pid}")
	end

	def debug_log(message)
		caller_info = caller(1).first
		message = "[#{caller_info}] #{message}"
		puts "[DEBUG] #{message}" if ENV['DEBUG_MODE'] == 'true'
	end

private
	def process_on_finish
		debug_log("Sub process on finish, pid: #{Process.pid}")
		@status = :finished;
		@job.record_file.flush;
		@job.record_file.close;
	end

end 