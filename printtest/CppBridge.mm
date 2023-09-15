// CppBridge.mm
#include "MyCppCode.hpp"

extern "C" {
    void printHelloWorldFromCppBridge() {
        printHelloWorldFromCpp();
    }
}
