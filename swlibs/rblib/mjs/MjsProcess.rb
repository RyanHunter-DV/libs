require_relative 'MjsCommand'
require_relative '../printer'
require 'open3'
class MjsProcess
	attr :job;
	attr :job_id;
	attr :debug;

	# :init, :running, :finished, :killed
	attr :status;

	def initialize(job,verbo=5)
		@job = job;
		@status = :init;
		@debug = Printer.new(verbo, :severity=>:DEBUG);
		@debug > "Initializing MjsProcess with job: #{job.inspect}"
	end

	def record_time(type,time)
		type = type.to_s.upcase+"_TIME";
		@job.record_file.record(type,time);
	end

	def record_output(output)
		@debug > "Recording output: #{output}"
		@job.record_file.record('OUTPUT',output);
	end

	def record_error(error)
		@debug > "Recording error: #{error}"
		@job.record_file.record('ERROR',error);
	end

	def record_status(status)
		@job.record_file.record('STATUS',status.to_s.upcase);
	end

	def record_command(type,command)
		if type == :external
			@job.record_file.record('COMMAND',command);
		else
			@job.record_file.record('COMMAND',command);
		end
	end

	def start
		@debug > "Starting process with status: #{@status}"
		@status = :running;
		job=@job;
		pid = fork do
			@debug > "Forked process with PID: #{Process.pid}"
			job.record_file(Process.pid.to_s);
			record_status(:running);
			record_command(job.type,job.exec);
			if job.type == :external
				@debug > "(#{Process.pid}) Executing external job: #{job.exec}"
				record_time(:start,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
				stdout, stderr, status = Open3.capture3(job.exec)
				record_time(:finish,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
				job.record_file.logging_output(stdout,stderr);
			else
				@debug > "Executing internal job: #{job.exec}"
				record_time(:start,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
				job.context.instance_eval(&job.exec);
				record_time(:finish,Time.now.strftime("%Y-%m-%d %H:%M:%S"))
			end
			process_on_finish;
			@debug > "Process completed, exiting, job status: #{@status}"
			exit!
		end
		@job_id = pid;
		Process.detach(pid)
		@debug > "Process detached with job_id: #{@job_id}"
		@debug > "Process finished, pid: #{pid}"
	end
	def wait_process_done
		first_line = `head -n 1 record_data-#{@job_id}.txt`.strip
		if first_line
			if /RECORD_DATA-STATUS: FINISHED/=~first_line
				puts "detecting finished status for job_id: #{@job_id}, update self.status to :finished"
				@status = :finished
			elsif /RECORD_DATA-STATUS: KILLED/=~first_line
				puts "detecting killed status for job_id: #{@job_id}, update self.status to :killed"
				@status = :killed
			else
				@debug > "current recorded status: #{first_line}, wait for 5 seconds"
				sleep(5)
				return wait_process_done
			end
		end
	end

	def get_status
		first_line = `head -n 1 record_data-#{@job_id}.txt`.strip
		if first_line
			if /RECORD_DATA-STATUS: FINISHED/=~first_line
				@status = :finished
			elsif /RECORD_DATA-STATUS: KILLED/=~first_line
				@status = :killed
			end
		end
		return @status;
	end

	def await
		puts("Awaiting process with pid: #{@job_id} at #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}")
		puts("status of job_id: #{@job_id} is #{@status}")
		if @status != :finished && @status != :killed
			wait_process_done
		end
		puts("Process with pid: #{@job_id} finished at #{Time.now.strftime("%Y-%m-%d %H:%M:%S")}")
	end

private
	def process_on_finish
		@debug > "Sub process on finish, pid: #{Process.pid}"
		record_status(:finished);
		@job.record_file.close;
	end

end 