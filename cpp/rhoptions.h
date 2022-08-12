#ifndef rhoptions__h
#define rhoptions__h

#include <rhstring.h>
#include <rhqueue.h>

namespace RHLib {

typedef enum {
	switches,
	single,
	multiple
} OptionType;

class OptionItem {
public:
	OptionItem(const char* _id,OptionType _t,const char* _d) {
		id = new String(_id);
		t  = _t;
		active = false;
		desc = new String(_d);
	}

	// returns the string pointer which contains a parameter by specified index.
	//
	String* param(int index=0);
	// return value of active field. which indicates if the option has been specified by user command line.
	//
	bool actived();
	
	// public fields
	Queue<String*> formats;
	Queue<String*> params;
private:
	String* id;
	String* desc;
	OptionType t;

	bool active;
};

class Options {
public:
	Options() {};

	// define a switch option that supported by the program
	// - id is used to set/get information of the defined option
	// - format is used to detect user inputs, '|' is a separator that to separates multiple formats
	// - desc is the description when printing help information
	// - default is the default value if user not entered this option
	void switches(const char* id,const char* format,const char* desc,bool default=false);

	// to declare an option that can only have 1 param
	void single(const char* id,const char* format,const char* desc,const char* default);

	// to declare an option that can store multiple params
	// multiple options has no default param
	void multiple(const char* id,const char* format,const char* desc);

	void parseArgs(int argc, const char* argv[]);


	// return true if user entered this opt, else return false, support for all types of options.
	// prototype: bool operator() (const char* id);
	bool operator () (const char* id);

	// return param of single opts, if opt entered is not single, then return “”
	// prototype: string* param(const char* id);
	String* param(const char* id);

	// return params of multiple opt, if opt entered is not multiple, then return empty queue
	// prototype: queue<string*>* params(const char* id);
	Queue<String*>* params(const char* id);


private:
	Queue<OptionItem*> opts;

};

};


#endif
