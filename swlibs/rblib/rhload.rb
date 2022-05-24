## rhload.rb
## this lib is for loading *.rh files in rhFlow, which let users to load a file
## without the extension, for example
## rhload 'path/file' can load path/file.rh
## beside, this method can automatically add the path of that file into search path
## TODO, add support of $LOAD_PATH, so that rhload can search and detect files if they are
## in range of $LOAD_PATH
def rhload fname; ##{

	extPtrn = /\.rh/;

	if not extPtrn =~ fname
		fname += '.rh';
	end

	## search file
	$LOAD_PATH.each do |p|
		if File.exists?(File.join(p,fname))
			load fname;
			break;
		end
	end

	## push dir to LOAD_PATH
	dir = File.dirname(File.absolute_path(fname));
	$LOAD_PATH << dir unless $LOAD_PATH.include?(dir);
	
end ##}
