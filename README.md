# cpsc-uleth

A docker image containing **some** of the necessary tools and libraries used for Computer Science at the University of Lethbridge

## Image details

 - OS: [ubuntu:focal](https://hub.docker.com/_/ubuntu)

 - Included Libaries:

  - [googletest](https://github.com/google/googletest) (for unit testing)
  - [doxygen](https://www.doxygen.nl/index.html) (for documentation generation)
  - [valgrind](https://valgrind.org/) (for checking memory leaks)
  - [cpplint](https://github.com/cpplint/cpplint) (for style checking)
  - [cppcheck](http://cppcheck.sourceforge.net/) (for static analysis)

## Tags

- latest
- software-eng: contains some additional libraries useful for CPSC3720
  - [nlohmann/json](https://github.com/nlohmann/json) (for using JSON objects within C++)
  - [restbed](https://github.com/Corvusoft/restbed) (for creating a C++ REST service)
