import re;

class CommentStrainer: #{

	startFlag = None;
	endFlag = '$';

	def __init__(self,S,E): #{
		if S==None or E==None:
			print("[commentSift::FATAL] invalid comment flag detected !!!");
		self.startFlag = S;
		self.endFlag = E;
	#}


	def sift(self,cnts): #{
		sifted = [];
		inMultLineComment = False;
		startRe = re.compile(self.startFlag);
		endRe = re.compile(self.endFlag);
		for cnt in cnts: #{
			cnt = cnt.rstrip('\n');
			sM = startRe.search(cnt);
			eM = endRe.search(cnt);
			if sM and eM:
				sifted.append(self._siftSingleLineComment(cnt,sM,eM));
				continue;
			if sM:
				inMultLineComment=True;
				sifted.append(self._siftSingleLineComment(cnt,s=sM,e=None));
				continue;
			if eM and inMultLineComment:
				inMultLineComment=False;
				sifted.append(self._siftSingleLineComment(cnt,s=None,e=eM));
				continue;

			if inMultLineComment:
				continue;

			sifted.append(cnt);
		#}
		return sifted;
	#}

	def _siftSingleLineComment(self,cnt,s,e): #{
		sPos=0;ePos=len(cnt)-1;
		if s: sPos = s.start();
		if e: ePos = e.end()-1;

		##TODO,print("debug");
		##TODO,print("cnt:",cnt);
		##TODO,print("len:",len(cnt));
		##TODO,print("sPos:",sPos);
		##TODO,print("ePos:",ePos);

		if sPos==0 and ePos==len(cnt)-1: return '';
		if sPos>0 and ePos==len(cnt)-1: return cnt[0:sPos];
		if sPos==0 and ePos<len(cnt)-1: return cnt[ePos+1:];
		else: return cnt[0:sPos]+cnt[ePos+1:];
	#}


#}
