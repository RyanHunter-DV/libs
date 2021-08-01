//
//  cppArray.hpp
//  fo
//
//  Created by huangqi on 2021/7/19.
//

#ifndef cppArray_hpp
#define cppArray_hpp

/* support APIs

- resize, reallocate the size of the array, keep original elements if exists.
- push, push an element at the end of the array
- pop, pop the first element from the array
- TODO,


*/





#include <stdint.h>
#include <iostream>

using namespace std;

#define templateHead template <class arrayT>
#define templateHeadClass(returnT) template <class arrayT> returnT cppArray<arrayT>

templateHead class cppArray
{
	public:
		cppArray(uint32_t len=0);
		~cppArray();
		void push(arrayT *element); // for pushing class objects
		void push(arrayT element); // for pushing normal variables
		void resize(int lenToChange);
		arrayT pop();
		bool isEmpty();
		uint32_t size();
		
	private:
		uint32_t m_newedArraySize;
		uint32_t m_usedArraySize;
		arrayT (*m_arrayElement) = NULL;
		void __shiftArrayElementOneStepPreviously();
		void _updateNewedArraySize(uint32_t size);
		void _copyElement(arrayT* target, arrayT* original, uint32_t size);
	
};


templateHeadClass()::cppArray(uint32_t len)
{
	m_newedArraySize = len;
	m_usedArraySize = 0;
	if (m_newedArraySize)
	{
		m_arrayElement = new arrayT [m_newedArraySize];
	}
}

templateHeadClass()::~cppArray()
{
	if (m_arrayElement != NULL)
	{delete m_arrayElement;}
}

templateHeadClass(void)::push(arrayT element)
{
	if (m_newedArraySize <= m_usedArraySize) {resize(1);}
	m_arrayElement[m_usedArraySize] = element;
	m_usedArraySize++;
	
	return;
}

templateHeadClass(uint32_t)::size()
{
	return m_usedArraySize;
}

templateHeadClass(void)::resize(int lenToChange)
{
	int newArraySize = m_newedArraySize + lenToChange;
	arrayT* originalArrayPoint = m_arrayElement;
	
	if (newArraySize <= 0)
	{
		cout << "cppArray FATAL: illegal resize operation because target size <= 0" << endl;
		return;
	}
	m_arrayElement = new arrayT [newArraySize];
	
	uint32_t smallerSize;
	if (newArraySize < m_newedArraySize)
	{
		smallerSize = newArraySize;
	} else {
		smallerSize = m_newedArraySize;
	}
	_copyElement(m_arrayElement,originalArrayPoint,smallerSize);
	_updateNewedArraySize(newArraySize);

}

templateHeadClass(void)::_copyElement(
	arrayT* target,
	arrayT* original,
	uint32_t size
)
{
	for (int i=0;i<size;i++)
	{
		*(target+i) = *(original+i);
	}
}

templateHeadClass(void)::_updateNewedArraySize(uint32_t size)
{
	m_newedArraySize = size;
}

templateHeadClass(bool)::isEmpty()
{
	if (m_usedArraySize == 0) {return true;}
	return false;
}

templateHeadClass(arrayT)::pop()
{
	if (isEmpty()) {return NULL;}
	arrayT elementReturned = m_arrayElement[0];
	__shiftArrayElementOneStepPreviously();
	m_usedArraySize--;
	
	return elementReturned;
}

templateHeadClass(void)::__shiftArrayElementOneStepPreviously()
{
	int maxLoop = m_usedArraySize-1;
	
	for (int i=0;i<maxLoop;i++)
	{
		m_arrayElement[i] = m_arrayElement[i+1];
	}
	
	return;
}


#undef templateHead
#undef templateHeadClass


#endif /* cppArray_hpp */
