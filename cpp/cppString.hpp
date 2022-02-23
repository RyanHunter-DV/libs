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


/* external execution of cppString */ // ##{{{
bool cppString::isEqualTo(const char *rhs)
{
	uint32_t rhsLen = cppString::instantLen(rhs);
	
	if (m_rawStringLen != rhsLen) {return false;}
	
	for (int i=0;i<rhsLen;i++)
	{
		if (*(m_rawString+i) != *(rhs+i)) {return false;}
	}
	
	return true;
}

void cppString::__internalInitStringMembers(char *initString)
{
	uint32_t initStringLen = cppString::instantLen(initString);
	
	m_rawStringLen = initStringLen;
	m_rawString = new char[m_rawStringLen];
	
	cppString::instantCopyToPointer(initString,m_rawString);
	
	m_defaultCopyMode = CPPSTRING_SUITCOPY_MODE;

}
cppString::cppString()
{
	m_defaultCopyMode = CPPSTRING_SUITCOPY_MODE;
	m_rawString = NULL;
	m_rawStringLen = 0;
}
cppString::cppString(const char *initString)
{
	uint32_t initStringLen = cppString::instantLen(initString);
	char *noconstInitString = new char[initStringLen];
	
	cppString::instantCopyToPointer(initString,noconstInitString);
	__internalInitStringMembers(noconstInitString);
	return;
}
cppString::cppString(char *initString)
{
	__internalInitStringMembers(initString);
}


uint32_t cppString::instantLen(const char *string)
{
	uint32_t lenReturned = 0;
	
	countStringLenMacro(string,lenReturned);
	
	return lenReturned;
}

uint32_t cppString::instantLen(char *string)
{
	uint32_t lenReturned = 0;
	
	countStringLenMacro(string,lenReturned);
	return lenReturned;
}


void cppString::instantCopyToPointer(const char *string, char *pointer)
{
	uint32_t stringLen = cppString::instantLen(string);
	uint32_t index;
	
	for (index=0; index<stringLen; index++)
	{
		*(pointer+index) = *(string+index);
	}
	
	return;
}

uint32_t cppString::len()
{
	return m_rawStringLen;
}

void cppString::suitCopy(const char *originalString)
{
	uint32_t originalStringLen = cppString::instantLen(originalString);
	
	// cout << "debug originalStringLen " << originalStringLen << endl;
	char *noconstOriginalString = new char[originalStringLen];
	directStringCopyMacro(originalString,noconstOriginalString);

	suitCopy(noconstOriginalString);
	// cout << "debug get current string " << m_rawString << endl;
	delete [] noconstOriginalString;
	
	return;
}

void cppString::suitCopy(char *originalString)
{
	uint32_t originalStringLen = cppString::instantLen(originalString);
	
	this->_checkAndSuitStringSize(originalStringLen);
	
	this->_rawCopyWithSpecificLength(m_rawStringLen, originalString);

}

void cppString::clipCopy(const char *originalString)
{
	uint32_t originalStringLen = cppString::instantLen(originalString);
	char *noconstOriginalString = new char[originalStringLen];
	
	directStringCopyMacro(originalString,noconstOriginalString);
	clipCopy(noconstOriginalString);
	delete [] noconstOriginalString;
	
	return;
}

void cppString::clipCopy(char *originalString)
{
	uint32_t specificStringLen;
	uint32_t originalStringLen = cppString::instantLen(originalString);
	
	if (originalStringLen > m_rawStringLen)
	{
		specificStringLen = m_rawStringLen;
	} else {
		specificStringLen = originalStringLen;
	}
	_rawCopyWithSpecificLength(specificStringLen, originalString);

	return;
}

void cppString::copy(const char *originalString)
{
	uint32_t originalStringLen = cppString::instantLen(originalString);
	char *noconstOriginalString = new char[originalStringLen];
	
	directStringCopyMacro(originalString,noconstOriginalString);
	copy(noconstOriginalString);
	delete [] noconstOriginalString;
	
	return;
}

void cppString::copy(char *originalString)
{
	if (m_defaultCopyMode == CPPSTRING_CLIPCOPY_MODE)
	{
		clipCopy(originalString);
	} else {
		suitCopy(originalString);
	}
}

void cppString::_checkAndSuitStringSize(uint32_t size)
{
	if (m_rawStringLen != size)
	{
		m_rawString = new char[size];
		m_rawStringLen = size;
	}
	
	return;
}

void cppString::_rawCopyWithSpecificLength(uint32_t length, char *originalString)
{
	uint32_t index;
	
	for (index=0; index<length; index++)
	{
		*(m_rawString+index) = *(originalString+index);
	}
	
	return;
}

char *cppString::getString()
{
	return m_rawString;
}

cppString::~cppString()
{
	delete [] m_rawString;
}

void cppString::append(const char *src, const char split)
{
	uint32_t srcLen = cppString::instantLen(src);
	
	_resizeKeepOriginalString(srcLen);
	
	uint32_t startAppendIndex = m_rawStringLen;
	if (split != '\0')
	{
		*(m_rawString+startAppendIndex) = split;
		startAppendIndex++;
		m_rawStringLen++;
	}
	for (int index=startAppendIndex;index<srcLen+startAppendIndex;index++)
	{
		*(m_rawString+index) = *(src+index-startAppendIndex);
	}
	m_rawStringLen+=srcLen; // update m_rawStringLen
	
	return;
}

void cppString::_resizeKeepOriginalString(uint32_t len)
{
	char *tmpOriginalString = m_rawString;
	
	m_rawString = new char[m_rawStringLen+len];
	
	if (tmpOriginalString != NULL)
	{
		directStringCopyMacro(tmpOriginalString,m_rawString);
		delete tmpOriginalString;
	}
	
	return;
}
// ##}}}


#endif /* cppString_hpp */
