#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
int var = 0;
void* child_fn ( void* arg ) {
   var++; /* Unprotected relative to parent / / this is line 6 */
   return NULL;
}

int main ( void ) {
   int* a=(int*)(malloc(sizeof(int)*10));
  
   pthread_t child;
   pthread_create(&child, NULL, child_fn, NULL);
   var++; /* Unprotected relative to child / / this is line 13 */
   pthread_join(child, NULL);
   return 0;
}
