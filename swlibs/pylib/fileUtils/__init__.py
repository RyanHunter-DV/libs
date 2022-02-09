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
	pCnts = [];
	for cnt in rCnts:
		pCnts.append(cnt.rstrip('\n'));
		
	return pCnts;
	
#}
