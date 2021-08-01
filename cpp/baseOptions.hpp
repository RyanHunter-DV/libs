

#ifndef baseOptions_hpp
#define baseOptions_hpp

#include "cppString.hpp"
#include <stdint.h>

class optionFormat
{

};


class baseOptions
{
	public:
		baseOptions();
		void addSupportOption(
			cppString *optionPrefix,
			cppString *optionName,
			cppString *optionParam = NULL
		);
	
	private:
		//optionFormat *m_optionArray[];
		uint32_t m_optionNumer;

};

void baseOptions::addSupportOption(
	cppString *optionPrefix,
	cppString *optionName,
	cppString *optionParam
)
{

}


#endif /* baseOptions_hpp */
