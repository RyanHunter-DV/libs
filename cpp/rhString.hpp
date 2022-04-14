//
//  rhString.hpp
//  cppStudy
//
//  Created by huangqi on 2021/7/13.
//

#ifndef rhString_hpp
#define rhString_hpp

#include <stdint.h>
// #include <memop.hpp>

// #include <iostream>
// using namespace std;

/*
Features of rhString class:
- stores string
- get length of stored string
- get length of a string according to the argument
- copy string
-- from another rhString
-- from a char* argument
- TODO, regular expression features


*/

#define RHSTRING_SUITCOPY_MODE 0
#define RHSTRING_CLIPCOPY_MODE 1

#define countStringLenMacro(string,len) while (*(string+len) != '\0') {len++;}
#define directStringCopyMacro(original,target) \
	uint32_t __index = 0; \
	while (*(original+__index) != '\0') \
	{ \
		*(target+__index) = *(original+__index); \
		__index++; \
	}

class rhString
{
	public:
		rhString(const char *initString);
		rhString(char *initString);
		rhString();
		~rhString();
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

bool rhString::isEqualTo(const char* rhs)
{
	uint32_t rhsLen = rhString::instantLen(rhs);

	if (m_rawStringLen != rhsLen) { return false; }

	for (uint32_t i = 0; i < rhsLen; i++)
	{
		if (*(m_rawString + i) != *(rhs + i)) { return false; }
	}

	return true;
}

void rhString::__internalInitStringMembers(char* initString)
{
	uint32_t initStringLen = rhString::instantLen(initString);

	m_rawStringLen = initStringLen;
	m_rawString = new char[m_rawStringLen];

	rhString::instantCopyToPointer(initString, m_rawString);

	m_defaultCopyMode = RHSTRING_SUITCOPY_MODE;

}
rhString::rhString()
{
	m_defaultCopyMode = RHSTRING_SUITCOPY_MODE;
	m_rawString = NULL;
	m_rawStringLen = 0;
}
rhString::rhString(const char* initString)
{
	uint32_t initStringLen = rhString::instantLen(initString);
	char* noconstInitString = new char[initStringLen];
	rhString::instantCopyToPointer(initString, noconstInitString);
	__internalInitStringMembers(noconstInitString);
	return;
}
rhString::rhString(char* initString)
{
	__internalInitStringMembers(initString);
}


uint32_t rhString::instantLen(const char* string)
{
	uint32_t lenReturned = 0;

	countStringLenMacro(string, lenReturned);

	return lenReturned;
}

uint32_t rhString::instantLen(char* string)
{
	uint32_t lenReturned = 0;

	countStringLenMacro(string, lenReturned);
	return lenReturned;
}


void rhString::instantCopyToPointer(const char* string, char* pointer)
{
	uint32_t stringLen = rhString::instantLen(string);
	uint32_t index;

	for (index = 0; index < stringLen; index++)
	{
		*(pointer + index) = *(string + index);
	}

	return;
}

uint32_t rhString::len()
{
	return m_rawStringLen;
}

void rhString::suitCopy(const char* originalString)
{
	uint32_t originalStringLen = rhString::instantLen(originalString);

	// cout << "debug originalStringLen " << originalStringLen << endl;
	char* noconstOriginalString = new char[originalStringLen];
	directStringCopyMacro(originalString, noconstOriginalString);

	suitCopy(noconstOriginalString);
	// cout << "debug get current string " << m_rawString << endl;
	delete[] noconstOriginalString;

	return;
}

void rhString::suitCopy(char* originalString)
{
	uint32_t originalStringLen = rhString::instantLen(originalString);

	this->_checkAndSuitStringSize(originalStringLen);

	this->_rawCopyWithSpecificLength(m_rawStringLen, originalString);

}

void rhString::clipCopy(const char* originalString)
{
	uint32_t originalStringLen = rhString::instantLen(originalString);
	char* noconstOriginalString = new char[originalStringLen];

	directStringCopyMacro(originalString, noconstOriginalString);
	clipCopy(noconstOriginalString);
	delete[] noconstOriginalString;

	return;
}

void rhString::clipCopy(char* originalString)
{
	uint32_t specificStringLen;
	uint32_t originalStringLen = rhString::instantLen(originalString);

	if (originalStringLen > m_rawStringLen)
	{
		specificStringLen = m_rawStringLen;
	}
	else {
		specificStringLen = originalStringLen;
	}
	_rawCopyWithSpecificLength(specificStringLen, originalString);

	return;
}

void rhString::copy(const char* originalString)
{
	uint32_t originalStringLen = rhString::instantLen(originalString);
	char* noconstOriginalString = new char[originalStringLen];

	directStringCopyMacro(originalString, noconstOriginalString);
	copy(noconstOriginalString);
	delete[] noconstOriginalString;

	return;
}

void rhString::copy(char* originalString)
{
	if (m_defaultCopyMode == RHSTRING_CLIPCOPY_MODE)
	{
		clipCopy(originalString);
	}
	else {
		suitCopy(originalString);
	}
}

void rhString::_checkAndSuitStringSize(uint32_t size)
{
	if (m_rawStringLen != size)
	{
		m_rawString = new char[size];
		m_rawStringLen = size;
	}

	return;
}

void rhString::_rawCopyWithSpecificLength(uint32_t length, char* originalString)
{
	uint32_t index;

	for (index = 0; index < length; index++)
	{
		*(m_rawString + index) = *(originalString + index);
	}

	return;
}

char* rhString::getString()
{
	return m_rawString;
}

rhString::~rhString()
{
	delete[] m_rawString;
}

void rhString::append(const char* src, const char split)
{
	uint32_t srcLen = rhString::instantLen(src);

	_resizeKeepOriginalString(srcLen);

	uint32_t startAppendIndex = m_rawStringLen;
	if (split != '\0')
	{
		*(m_rawString + startAppendIndex) = split;
		startAppendIndex++;
		m_rawStringLen++;
	}
	for (int index = startAppendIndex; index < srcLen + startAppendIndex; index++)
	{
		*(m_rawString + index) = *(src + index - startAppendIndex);
	}
	m_rawStringLen += srcLen; // update m_rawStringLen

	return;
}

void rhString::_resizeKeepOriginalString(uint32_t len)
{
	char* tmpOriginalString = m_rawString;

	m_rawString = new char[m_rawStringLen + len];

	if (tmpOriginalString != NULL)
	{
		directStringCopyMacro(tmpOriginalString, m_rawString);
		delete tmpOriginalString;
	}

	return;
}


#endif /* rhString_hpp */
