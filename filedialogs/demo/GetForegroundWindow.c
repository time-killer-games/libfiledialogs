#include <stdio.h>
#include <windows.h>

int main() {
  printf("%llu", (unsigned long long)(void *)GetForegroundWindow());
}
