#include <stdio.h>

void escalar(float[4][4] , float[4][4]);
void transladar(float[4][4] , float[4][4] );
void rotar(float[4][4] , float[4][4] );

int main(){
    float matrixA[4][4] = {{1,1,1,1},
                        {1,1,1,1},
                        {1,1,1,1},
                        {1,1,1,1}};
    float matrixB[4][4] = {{1,1,1,1},
                        {1,1,1,1},
                        {1,1,1,1},
                        {1,1,1,1}};

    escalar(matrixA, matrixB);                        
    return 0;
}
