#ifndef rhqueue__h
#define rhqueue__h

namespace RHLib {


#include <stdlib.h>
#include <stdint.h>

template <class T>
class queue {
/*
    class of queue, which can store many different types, such as:
    - standard c++ data types
    - user defined class/class pointers
    ----------------------------------------------------------------
    supportive APIs:
    - pop(int idx=0)   // pop item from a specified position, default is index 0
    - push(int idx=-1) // push item to specified position, default is tail of queue
*/
public:

    // constructor/desctructor
    queue() {
        __size = 0;
        __ep = NULL;
    }
    ~queue() {
        if (__size != 0) {
            delete __ep;
            __size = 0;
        }
    }

	// push item into queue, the position is specified by idx arg, by default,
	// the idx=-1, which means to push item to the end of the queue, any other neg
	// idx are all mean to push item to the end of the queue.
	// if idx is positive but larger than current len, then an error will displayed.
	void push(T item,int idx=-1);

	// pop item from the queue, the position is specified by idx arg, by default,
	// the item[0] will be popped, if idx is negetivie, then the end of queue item
	// will be popped, if idx larger than queue len, an error will be displayed.
	T pop(int idx=0);

    // size(): gives number of items which stored in te queue currently
    uint32_t size();

    // del(idx), delete the idx specified item in the queue, if idx < 0, then
    // to delete the whole queue items.
    void del(int idx=-1);

private:
    // elements pointer
    T (*__ep);
    uint32_t __size;


    // _getPushIndex(idx), according to idx arg, return the actual index to be pushed in.
    // if idx < 0, return the end position, the returned index must >= 0
    uint32_t __getRealPushPopIndex(int idx); // TODO

    // _insertElementToIndex(item,idx), insert item arg into idx index, idx must >= 0
    // this func will also rearrange the original items, for example, if idx is 1, then
    // inserted item position is 1, and the original position 1 item will be moved to position
    // 2, ditto.
    void __insertElementToIndex(T item,uint32_t idx); // TODO

    // _updateQueueSize(change), the change arg can be positive or negetive, used to increase/decrease
    // the size of current queue. this operation will remap the memory space of queue
    void __updateQueueSize(int change);
    void __enlargeQueueSize(uint32_t add);
    void __shortenQueueSize(uint32_t sub);

    void __removeAll(); // clear current queue items
    void __removeSpecificItem(uint32_t idx);

};



};


#endif
