// this file is a lib for all memory operations, such as
//


#ifndef memop__hpp
#define memop__hpp

// this API used by rhString so it should be preceeded before including rhString.hpp
#define memoryClear(i) \
	int is = int(s); \
	for (int pos=0;pos<is;pos++) { \
		*(p + pos) = i; \
	} \
	return;

void clearAllocatedMemory(char* p, int s) { memoryClear('\0'); }
void clearAllocatedMemory(char* p, uint32_t s) { memoryClear('\0'); }

#include <rhString.hpp>

// memCopy, which can copy specified byte of data from source to destination
// the size(s) will affected by the input src/dest types
// this API cannot check the legality of the memory space, so users should
// confirm that all spaces are legal before calling this copy

#define memCopyOperation \
	if (s <= 0) { return -1; } \
	for (int i = 0; i < s; i++) { \
		*(dest + i) = *(src + i); \
	} \
	return 0;
int memCopy(int* src, int* dest, int s) {memCopyOperation;}
int memCopy(char* src, char* dest, int s) { memCopyOperation; }
int memCopy(rhString* src, rhString* dest, int s) { memCopyOperation; }
int memCopy(rhString** src, rhString** dest, int s) { memCopyOperation; }

// enlarge a given pointer with specific count of arg::s
void enlarge(void* p, int s) {
	if (s <= 0) { return; }
	// TODO
}



#undef memCopyOperation
#undef memoryClear

#endif