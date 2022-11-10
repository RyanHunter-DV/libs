## rhload.rb
## this lib is for loading *.rh files in rhFlow, which let users to load a file
## without the extension, for example
## rhload 'path/file' can load path/file.rh
## beside, this method can automatically add the path of that file into search path
## TODO, add support of $LOAD_PATH, so that rhload can search and detect files if they are
## in range of $LOAD_PATH
###################################################################################
## Revision History
###################################################################################
## 2022-8-17,
## - fix one bug:
## - while two dirs: design/dcache/node.rh, verif/dcache/node.rh, using rhload in
## - design/ and verif/ by rhload 'dcache/node' will load the same node.rh
## - update this:
## - remove procedures that add dirs into $LOAD_PATH, but will first search files
## - in current path, and if not found, then using $LOAD_PATH
###################################################################################

def rhload fname ##{

	if not (/\.rh/=~fname or /\.rb/=~fname)
		fname += '.rh';
	end

	stacks = (caller(1)[0]).split(':');
	if stacks==nil
		puts "Error, cannot get caller, no load will execute";
		return;
	end
	path = File.dirname(File.absolute_path(stacks[0]));
	## checking if the caller gives an abasolute path
	if File.exists?(fname)
		## load directly
		## dir = File.dirname(File.absolute_path(fname));
		## $LOAD_PATH << dir unless $LOAD_PATH.include?(dir);
		puts "DEBUG, load: #{File.absolute_path(fname)}";
		load fname;
		return;
	end

	## checking if the caller give an relative path
	f = File.join(path,fname);
	if File.exists?(f)
		puts "DEBUG, load: #{f}";
		load f;
		return;
	end

	## if not exists by the path, searching with LOAD_PATH
	$LOAD_PATH.each do |p|
		full = File.join(p,fname);
		if File.exists?(full)
			## push dir to LOAD_PATH
			## dir = File.dirname(File.absolute_path(full));
			## $LOAD_PATH << dir unless $LOAD_PATH.include?(dir);
			puts "DEBUG, load: #{full}";
			load full;
			return;
		end
	end

end ##}


##def rhload fname; ##{
##
##	extPtrn = /\.rh/;
##
##	if not extPtrn =~ fname
##		fname += '.rh';
##	end
##
##	if File.exists?(fname)
##		dir = File.dirname(File.absolute_path(fname));
##		$LOAD_PATH << dir unless $LOAD_PATH.include?(dir);
##		load fname;
##		return;
##	end
##
##	## search file
##	$LOAD_PATH.each do |p|
##		full = File.join(p,fname);
##		if File.exists?(full)
##			## push dir to LOAD_PATH
##			dir = File.dirname(File.absolute_path(full));
##			$LOAD_PATH << dir unless $LOAD_PATH.include?(dir);
##			load fname; ## add new path before load in case that rhload called in fname.
##			return;
##		end
##	end
##
##
##	
##end ##}
