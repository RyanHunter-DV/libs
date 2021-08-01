#ifndef cppString_cpp
#define cppString_cpp


#include "cppString.hpp"

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


#endif