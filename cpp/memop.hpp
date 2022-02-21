// this file is a lib for all memory operations, such as
//


#ifndef memop__hpp
#define memop__hpp

// memCopy, which can copy specified byte of data from source to destination
// the size(s) will affected by the input src/dest types
// this API cannot check the legality of the memory space, so users should
// confirm that all spaces are legal before calling this copy
int memCopy(void* src, void* dest, int s)
{
	if (s <= 0) { return -1; }
	for (int i = 0; i < s; i++) {
		*(dest + i) = *(src + i);
	}
	return 0;
}

// enlarge a given pointer with specific count of arg::s
void enlarge(void* p, int s) {
	if (s <= 0) { return; }
	// TODO
}

#endif