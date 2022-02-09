import sys;
import os;

path = os.path.dirname(os.path.abspath(__file__));
sys.path.append(path);


def getContents(name): #{
	rCnts = [];
	if not os.path.isfile(name): #{
		print("[fileUtils::FATAL] file not exists:",name);
		return [];
	#}
	
	fh = open(name,mode='r');
	rCnts = fh.readlines();
	fh.close();
	pCnts = [];
	for cnt in rCnts:
		pCnts.append(cnt.rstrip('\n'));
		
	return pCnts;
	
#}

## generate a new file with cnts, if cnts==None, generate an empty file
## by using this API, file will be overwritten even if it exists.
def newFile(name,cnts=None): #{
	fh = open(name,mode='w');
	if cnts==None:
		fh.flush();
	else: #{
		for cnt in cnts:
			fh.write(cnt+'\n');
	#}
	fh.close();
	return;
#}
