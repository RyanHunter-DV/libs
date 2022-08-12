#ifndef rhqueue__cpp
#define rhqueue__cpp

namespace RHLib {

#include <rhqueue.h>
#include <rhstring.h>
#include <memop.h>

// User API Start {
template <class T>
void queue<T>::push(T item,int idx) {
    uint32_t pushIndex = __getRealPushPopIndex(idx);
    __updateQueueSize(1); // allocate new memory space
    __insertElementToIndex(item,pushIndex);
}

template <class T>
T queue<T>::pop(int idx) {
    uint32_t popIndex = __getRealPushPopIndex(idx);
    T item = *(__ep+idx);
    del(idx);
    return item;
}

template <class T>
void queue<T>::del(int idx) {
    if (idx < 0) {
        __removeAll();
    } else {
        __removeSpecificItem(idx);
    }
    return;
}

template <class T>
uint32_t queue<T>::size() {
    return __size;
}

// User API End }


// internal functions
template <class T>
void queue<T>::__removeSpecificItem(uint32_t idx) {
    if (idx >= __size) {return;}
    for (int i=idx;i<__size-1;i++) {
        *(__ep+i) = *(__ep+i+1);
    }
    __updateQueueSize(-1);
    return;
}

template <class T>
void queue<T>::__removeAll() {
    delete __ep;
    __size = 0;
}
template <class T>
void queue<T>::__insertElementToIndex(T item,uint32_t idx) {
    if (idx>=__size) {return;}
    for (int i=__size-1;i>idx;i--) {
        *(__ep+i) = *(__ep+i-1);
    }
    *(__ep+idx) = item;
    return;
}

template<class T>
uint32_t queue<T>::__getRealPushPopIndex(int idx) {
    if (idx < 0) {
        idx = __size; // select last index
    } else {
        return idx;
    }
}

template<class T>
void queue<T>::__updateQueueSize(int change) {
    if (change > 0) {
        __enlargeQueueSize(change);
        return;
    }
    if (change < 0) {
        __shortenQueueSize(-change);
        return;
    }
}


template<class T>
void queue<T>::__enlargeQueueSize(uint32_t add) {
    uint32_t ns = __size + add; // new size
    T* np = requireMemory<T>(ns);
    if (__size != 0) {
        if (memCopy<T>(__ep,np,ns)!=0) {
            // copy failed
            delete np;
            return;
        }
        delete __ep;
    }
    __ep = np;
    __size = ns;
}

template<class T>
void queue<T>::__shortenQueueSize(uint32_t sub) {
    uint32_t ns=__size-sub;
    if (ns == 0) {
        // clear the queue
        delete __ep;
        __size = 0;
    } else {
        T* np = requireMemory<T>(ns);
        if (memCopy<T>(__ep,np,ns)!=0) {
            // copy failed
            delete np;
            return;
        }
        delete __ep;
        __ep = np;
        __size = ns;
    }
}



using intQueue = queue<int>;
using strQueue = queue<rhstring>;

void __markForTemplateLinkingIssue() {
    queue<int> qi;
    queue<rhstring> qs;
    queue<rhstring*> qsp;
}


};

#endif
