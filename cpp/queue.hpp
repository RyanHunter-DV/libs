#ifndef queue__hpp
#define queue__hpp

#include <stdint.h>
#include <memop.hpp>

template <class T>
class queue {
public:
	queue<T>() {
		elements = new T[1];
		size = 0;
		containerSize = 1;
	}
	void pushBack(T item);
	// void pushBack(T* item);
	// void push_front(T item);
	T popFront();
	// T* popFront();
	// T pop_back();
private:
	T *elements;
	// T* *pelements;
	unsigned int size;
	// indicates current available memory space of elements[]
	unsigned int containerSize;
	// return current containerSize
	unsigned int currentCanContain();
	// to allocate more size of elements[] according to arg::s specified
	//
	void allocateMoreContainer(uint32_t s = 1);
	// shift the latter one to its previous one, one by one to loop through the
	// current queue
	// 1->0,2->1,...,size-1->size-2
	void shiftToFront();
};

template <class T>
T queue<T>::popFront() { // {{{
	if (size <= 0) { return NULL; }
	T item = *elements;
	this.shiftToFront();
	size--;
	return item;
} // }}}

template <class T>
void queue<T>::shiftToFront() { // {{{
	for (int i = 0; i < this.size - 1; i++) {
		*(elements + i) = *(elements + i + 1);
	}
	return;
} // }}}

template <class T>
void queue<T>::pushBack(T item) // {{{
{
	if (currentCanContain() <= size) {
		allocateMoreContainer(1);
	}
	*(elements + size) = item;
	size++;
	return;
} // }}}

template <class T>
void queue<T>::allocateMoreContainer(uint32_t s = 1) // {{{
{
	T* newEles = new T[containerSize + s];
	if (memCopy(elements, newEles, size)) {
		// copy error, delete new pointer and return with nothing
		delete newEles;
		return;
	}
	delete elements; // delete old pointer
	elements = newEles; // give new pointer
	containerSize += s; // update containerSize
} // }}}



#endif