#ifndef rhstring__cpp
#define rhstring__cpp

namespace RHLib {

#include <stdlib.h>
#include <rhstring.h>

bool string::operator == (const char* rhs)
{
	uint32_t rhsLen = string::instantLen(rhs);

	if (m_rawStringLen != rhsLen) { return false; }

	for (uint32_t i = 0; i < rhsLen; i++)
	{
		if (*(m_rawString + i) != *(rhs + i)) { return false; }
	}

	return true;
}

bool string::operator == (string *rhs)
{
	uint32_t rhsLen = string::instantLen((*rhs)());

	if (m_rawStringLen != rhsLen) { return false; }
    char *rhsp = (*rhs)();
	for (uint32_t i = 0; i < rhsLen; i++)
	{
		if (*(m_rawString + i) != *(rhsp + i)) { return false; }
	}

	return true;
}

void string::__internalInitStringMembers(char* initString)
{
	uint32_t initStringLen = string::instantLen(initString);

	m_rawStringLen = initStringLen;
	m_rawString = new char[m_rawStringLen];

	string::instantCopyToPointer(initString, m_rawString);

	m_defaultCopyMode = STRING_SUITCOPY_MODE;

}
string::string()
{
	m_defaultCopyMode = STRING_SUITCOPY_MODE;
	m_rawString = NULL;
	m_rawStringLen = 0;
}
string::string(const char* initString)
{
	uint32_t initStringLen = string::instantLen(initString);
	char* noconstInitString = new char[initStringLen];
	string::instantCopyToPointer(initString, noconstInitString);
	__internalInitStringMembers(noconstInitString);
	return;
}
string::string(char* initString)
{
	__internalInitStringMembers(initString);
}


uint32_t string::instantLen(const char* string)
{
	uint32_t lenReturned = 0;

	countStringLenMacro(string, lenReturned);

	return lenReturned;
}

uint32_t string::instantLen(char* string)
{
	uint32_t lenReturned = 0;

	countStringLenMacro(string, lenReturned);
	return lenReturned;
}


void string::instantCopyToPointer(const char* string, char* pointer)
{
	uint32_t stringLen = string::instantLen(string);
	uint32_t index;

	for (index = 0; index < stringLen; index++)
	{
		*(pointer + index) = *(string + index);
	}

	return;
}

uint32_t string::len()
{
	return m_rawStringLen;
}

void string::suitCopy(const char* originalString)
{
	uint32_t originalStringLen = string::instantLen(originalString);

	// cout << "debug originalStringLen " << originalStringLen << endl;
	char* noconstOriginalString = new char[originalStringLen];
	directStringCopyMacro(originalString, noconstOriginalString);

	suitCopy(noconstOriginalString);
	// cout << "debug get current string " << m_rawString << endl;
	delete[] noconstOriginalString;

	return;
}

void string::suitCopy(char* originalString)
{
	uint32_t originalStringLen = string::instantLen(originalString);

	this->_checkAndSuitStringSize(originalStringLen);

	this->_rawCopyWithSpecificLength(m_rawStringLen, originalString);

}

void string::clipCopy(const char* originalString)
{
	uint32_t originalStringLen = string::instantLen(originalString);
	char* noconstOriginalString = new char[originalStringLen];

	directStringCopyMacro(originalString, noconstOriginalString);
	clipCopy(noconstOriginalString);
	delete[] noconstOriginalString;

	return;
}

void string::clipCopy(char* originalString)
{
	uint32_t specificStringLen;
	uint32_t originalStringLen = string::instantLen(originalString);

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

void string::copy(const char* originalString)
{
	uint32_t originalStringLen = string::instantLen(originalString);
	char* noconstOriginalString = new char[originalStringLen];

	directStringCopyMacro(originalString, noconstOriginalString);
	copy(noconstOriginalString);
	delete[] noconstOriginalString;

	return;
}

void string::copy(char* originalString)
{
	if (m_defaultCopyMode == STRING_CLIPCOPY_MODE)
	{
		clipCopy(originalString);
	}
	else {
		suitCopy(originalString);
	}
}

void string::_checkAndSuitStringSize(uint32_t size)
{
	if (m_rawStringLen != size)
	{
		m_rawString = new char[size];
		m_rawStringLen = size;
	}

	return;
}

void string::_rawCopyWithSpecificLength(uint32_t length, char* originalString)
{
	uint32_t index;

	for (index = 0; index < length; index++)
	{
		*(m_rawString + index) = *(originalString + index);
	}

	return;
}

char* string::operator () ()
{
	return m_rawString;
}

char* string::get() {
	return m_rawString;
}

string::~string()
{
	delete[] m_rawString;
}

void string::operator += (const char* src) {
	uint32_t srcLen = string::instantLen(src);

	_resizeKeepOriginalString(srcLen);

	uint32_t startAppendIndex = m_rawStringLen;

	for (int index = startAppendIndex; index < srcLen + startAppendIndex; index++)
	{
		*(m_rawString + index) = *(src + index - startAppendIndex);
	}
	m_rawStringLen += srcLen; // update m_rawStringLen

	return;
}

void string::append(const char* src, const char split)
{
	uint32_t srcLen = string::instantLen(src);

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

void string::_resizeKeepOriginalString(uint32_t len)
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

};

#endif
