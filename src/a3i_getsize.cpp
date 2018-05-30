/**
 * A reader of the first file size from .tar.bz2 archives
 *
 * Author: Al Korgun <korgun@tbdd.ru>
 **/

#include <inttypes.h>
//#include <cmath>
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

	printf("%" PRIu64 "\n", size);

	file.close();

	return 0;
}
