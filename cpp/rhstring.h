#ifndef rhstring__h
#define rhstring__h


namespace RHLib {

#include <stdint.h>
// #include <memop.hpp>

// #include <iostream>
// using namespace std;

/*
Features of string class:
- stores string
- get length of stored string
- get length of a string according to the argument
- copy string
-- from another string
-- from a char* argument
- TODO, regular expression features

------------------------------------------------------------------------------------------------
string strA("strA");
string strB("strB");
strA == strB, equality check,rhs is another string, if strA and strB has same string, return true, else return false
strA == "const string", equality check, rhs is const string, others are same as above
strA(), returns pointer of the string.
*/

#define STRING_SUITCOPY_MODE 0
#define STRING_CLIPCOPY_MODE 1

#define countStringLenMacro(string,len) while (*(string+len) != '\0') {len++;}
#define directStringCopyMacro(original,target) \
	uint32_t __index = 0; \
	while (*(original+__index) != '\0') \
	{ \
		*(target+__index) = *(original+__index); \
		__index++; \
	}

class string
{
	public:
		string(const char *initString);
		string(char *initString);
		string();
		~string();
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
		char* operator () ();
		// same as operator(), this is used more meaningful while getting char* through an string pointer.
		// string str("hello");
		// string* pStr = str;
		// pStr->get() // is same as str()
		char* get();
        // equality check, check they have same string or not.
		bool operator == (const char *rhs);
        bool operator == (string *rhs);
        // simply append a string, without any separator.
        // a+="hello", then hello will directly added at the end of a.
        void operator +=(const char *src);

        // append a string with specified separator
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

};

#endif
