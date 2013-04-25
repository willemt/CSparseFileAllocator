GCOV_OUTPUT = *.gcda *.gcno *.gcov 
GCOV_CCFLAGS = -fprofile-arcs -ftest-coverage
CC     = gcc
CCFLAGS = -g -O2 -Wall -Werror -W -fno-omit-frame-pointer -fno-common -fsigned-char $(GCOV_CCFLAGS)


all: tests

main.c:
	sh make-tests.sh > main.c

tests: main.c sparsefile_allocator.o test_sparsefile_allocator.c CuTest.o main.c
	$(CC) $(CCFLAGS) -o $@ $^
	./tests
	gcov main.c test_sparsefile_allocator.c sparsefile_allocator.c

sparsefile_allocator.o: sparsefile_allocator.c
	$(CC) $(CCFLAGS) -c -o $@ $^

CuTest.o: CuTest.c
	$(CC) $(CCFLAGS) -c -o $@ $^

clean:
	rm -f main.c sparsefile_allocator.o tests $(GCOV_OUTPUT)
