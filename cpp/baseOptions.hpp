

#ifndef baseOptions_hpp
#define baseOptions_hpp

#include "cppString.hpp"
#include <stdint.h>

struct formattedOption_t
{
	cppString *prefix = NULL;
	cppString *name = NULL;
	bool hasParam = false;
	int appearance = 0;
	cppString *param[];
};


class baseOptions
{
	public:
		formattedOption_t getOption(
			const char prefix,
			const char *option,
			const char flagConnectToParam = ' ',
			cppString *args,
			bool hasParam = false
		);
		
		void convertArgvToString(
			int argc,
			const char *argv[],
			cppString *string
		);
		
	private:
		//optionFormat *m_optionArray[];
		uint32_t m_optionNumer;

};

// TODO,

formattedOption_t baseOptions::getOption(
	const char prefix,
	const char *option,
	const char flagConnectToParam,
	cppString *args,
	bool hasParam
)
{
	cppString fullOptionString;
	const int REMOVE = 1;
	_getFullOptionString(
		prefix,
		option,
		flagConnectToParam,
		&fullOptionString
	);
	
}

void baseOptions::convertArgvToString(
	int argc,
	const char *argv[],
	cppString *string
)
{
	for (int argvIndex=0;argvIndex<argc;argvIndex++)
	{
		string->append(argv[argvIndex],' ');
	}
	
}



#endif /* baseOptions_hpp */
