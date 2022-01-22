The aim of this repository is to create a makefile that can create a full,
correct, and minimal dependency graph of a C project, with automatic
prerequisites for header file dependencies, and the caveat that header files
are generated as part of the build process. The method of generating header
files is beyond the scope of this project, but to illustrate the concept, header
files will be given a .h.txt extension and "generated" using the "cp" command.

The tricky part of this project is the "minimal" requirement. It is actually
fairly simple to create a full and correct dependency graph, but the cost is
that every source file must be preprocessed up-front to generate the dependency
files. Ideally, these dependency files would not be generated unless they were
needed to determine whether to rebuild another target.
