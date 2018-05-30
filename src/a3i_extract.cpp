/**
 * An exctractor of the first file from .tar.bz2 archives
 *
 * Author: Al Korgun <korgun@tbdd.ru>
 **/

#include <inttypes.h>
#include <cmath>
#include <fstream>
#include <boost/iostreams/filtering_stream.hpp>
#include <boost/iostreams/filter/bzip2.hpp>

#include "a3i_base.cpp"

int main(int argc, char *argv[]) {
	using namespace std;
	using namespace boost::iostreams;

	ifstream file(argv[1], ifstream::binary);
	filtering_istream in;
	in.push(bzip2_decompressor());
	in.push(file);

	SimplifiedTarHeader header;

	in.read((char*) &header, sizeof header);

	uint64_t size = parseTarNumber(header.size, 12);

	float_t size_backup = (float_t) size;
	float_t size_p = size_backup / (float_t) 100.0;

	//printf("%s %" PRIu64 "\n", header.name, size);

	uint64_t progress; // percentage

	in.ignore(376); // unused end of tar header

	ofstream file_out(argv[2], ofstream::binary);

	int blk_size = 524288;
	while (size > 0) {
		blk_size = (int) min((uint64_t) blk_size, size);

		char* buff = new char[blk_size];

		in.read(buff, blk_size);
		file_out.write(buff, blk_size);

		delete[] buff;

		size -= (uint64_t) blk_size;

		if (size > 0) {
			progress = (uint64_t) ((size_backup - (float_t) size) / size_p);
		} else {
			progress = 100;
		}

		printf("%" PRIu64 "\n", progress);
	}

	file.close();
	file_out.close();

	return 0;
}
