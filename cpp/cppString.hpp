//
//  cppString.hpp
//  cppStudy
//
//  Created by huangqi on 2021/7/13.
//

#ifndef cppString_hpp
#define cppString_hpp

#include <stdint.h>

// #include <iostream>
// using namespace std;

/*
Features of cppString class:
- stores string
- get length of stored string
- get length of a string according to the argument
- copy string
-- from another cppString
-- from a char* argument
- TODO, regular expression features


*/

#define CPPSTRING_SUITCOPY_MODE 0
#define CPPSTRING_CLIPCOPY_MODE 1

#define countStringLenMacro(string,len) while (*(string+len) != '\0') {len++;}
#define directStringCopyMacro(original,target) \
	uint32_t __index = 0; \
	while (*(original+__index) != '\0') \
	{ \
		*(target+__index) = *(original+__index); \
		__index++; \
	}

class cppString
{
	public:
		cppString(const char *initString);
		cppString(char *initString);
		cppString();
		~cppString();
		uint32_t len();
		
		// suitCopy, copy from a string in argument to the class member, if the length in argument
		// is larger than m_rawString, then enlarge the size of m_rawString; if smaller than
		// m_rawString, then clip size of m_rawString.
		// clipCopy, same as suitCopy, except that when length of original string is larger than
		// m_rawString, the part that exceeds m_rawString's size will be ignored; or if is smaller
		// than m_rawString, then the whole string will be copied to m_rawString, other chars in
		// m_rawString will be kept.
		void suitCopy(char *originalString);
		void suitCopy(const char *originalString);
		void clipCopy(char *originalString);
		void clipCopy(const char *originalString);
		
		// default copy action, according to m_defaultCopyMode, choose suitCopy or clipCopy
		void copy(char *originalString);
		void copy(const char *originalString);
		char *getString();
		bool isEqualTo(const char *rhs);
		void append(const char *src, const char split='\0');
		
		static uint32_t instantLen(const char *string);
		static uint32_t instantLen(char *string);
		static void instantCopyToPointer(const char *string, char *pointer);
		

	private:
		char *m_rawString;
		uint32_t m_rawStringLen;
		uint32_t m_defaultCopyMode;
		
		void _checkAndSuitStringSize(uint32_t size);
		void _rawCopyWithSpecificLength(uint32_t length, char *originalString);
		void __internalInitStringMembers(char *initString);
		void _resizeKeepOriginalString(uint32_t len);

		

};




#endif /* cppString_hpp */
