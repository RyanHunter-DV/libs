#ifndef rhoptions__cpp
#define rhoptions__cpp

#include <rhoptions.h>
#include <rhstring.h>
namespace RHLib {



void Options::switches(const char* id,const char* format,const char* desc,bool default=false) {
	String* pFmt =new String(format);
	StringSplits* pSplits = pFmt.split('|');
	OptionItem* pOI = new OptionItem(id,switches,desc);
	for (int i=0;i<pSplits->num();i++) {
		pOI->formats.push(pSplits->get(i));
	}
	active = default;
}




};


namespace RHLib {

String* OptionItem::param(int index=0) {
	if (params.size()<=index) {return NULL;}
	return params[index];
}
bool OptionItem::actived() {
	return active;
}

};



#endif
