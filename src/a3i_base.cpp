/**
 * A minimal implementation of the TAR structures
 *
 * Author: Al Korgun <korgun@tbdd.ru>
 **/

struct SimplifiedTarHeader {
	char name[100];
	char __nu[24];
	char size[12];
	//char __ne[376]; //unread 376 bytes
};

uint64_t parseTarNumber(char* number, int size) { // octal, NULL-terminated
	uint64_t result = 0;

	if (number == 0) {
		return result;
	}

	for (char last; size > 0; ) {
		last = number[size - 1];
		if (last == 0 || last == 32) {
			size--;
		} else {
			break;
		}
	}

	for (int i = 0; i < size; i++) {
		result = (result << 3) + ((int) number[i] - 48);
	}

	return result;
}
