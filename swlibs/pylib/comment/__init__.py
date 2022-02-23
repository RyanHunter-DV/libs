import sys;
import os;

## add current libPath into python lib search path
libPath = os.path.dirname(os.path.abspath(__file__));
sys.path.append(libPath);

from commentStrainer import *;


def sift(cnts,S,E=None): #{
	if E==None: E='$';
	cs = CommentStrainer(S,E);
	return cs.sift(cnts);
#}

