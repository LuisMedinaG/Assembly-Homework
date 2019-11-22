#include <stdio.h>

//____FUNCIONES DE ENSAMBLADOR____
void sumaVectorial(float[], float[]);
int prodPunto(int[], int[]);
void prodCruz(int[], int[]);
void prodMatricial(int[4][4], int[4][4]);

void funcA() {
    float vecA[4];
    float vecB[4];

    printf("________ SUMA VECTORIAL ________ \n");
    printf("Escribe 4 enteros de tu vector A (# # # #): ");
    scanf("%f %f %f %f", &vecA[0], &vecA[1], &vecA[2],
          &vecA[3]);  // Introducimos los datos de vecA
    printf("Escribe 4 enteros de tu vector B (# # # #): ");
    scanf("%f %f %f %f", &vecB[0], &vecB[1], &vecB[2],
          &vecB[3]);  // Introducimos los datos de vecB

    // Mandamos llamar funcion construida en ensamblador
    sumaVectorial(vecA, vecB);  

    printf("Suma vectorial = {%.0f,%.0f,%.0f,%.0f}\n", vecA[0], vecA[1],
           vecA[2], vecA[3]);
}

void funcB() {
    int vecA[4];
    int vecB[4];
    int result = 0;

    printf("________ PRODUCTO PUNTO ________ \n");
    printf("Escribe 4 enteros de tu vector A (# # # #): ");
    scanf("%d %d %d %d", &vecA[0], &vecA[1], &vecA[2],
          &vecA[3]);  // Introducimos los datos de vecA
    printf("Escribe 4 enteros de tu vector B (# # # #): ");
    scanf("%d %d %d %d", &vecB[0], &vecB[1], &vecB[2],
          &vecB[3]);  // Introducimos los datos de vecB

    result = prodPunto(
        vecA, vecB);  // Mandamos llamar funcion construida en ensamblador

    printf("Producto escalar/punto = %d \n", result);
}

void funcC() {
    int vecA[3];
    int vecB[3];
    
    printf("________ PRODUCTO CRUZ ________ \n");
    printf("Escribe 3 enteros de tu vector A (# # #): ");
    scanf("%d %d %d", &vecA[0], &vecA[1],
          &vecA[2]);  // Introducimos los datos de vecA
    printf("Escribe 3 enteros de tu vector B (# # #): ");
    scanf("%d %d %d", &vecB[0], &vecB[1],
          &vecB[2]);  // Introducimos los datos de vecB
    prodCruz(vecA, vecB);
    printf("(A1 A2 A3)x(B1 B2 B3) = (%d %d %d) \n", vecA[0], vecA[1],
           vecA[2]);  // Modificamos valores de vecA
}

void funcD() {
    int matrixA[4][4];
    int matrixB[4][4];
    
    printf("________ PRODUCTO MATRICIAL ________ \n");
    printf("Escribe 4 enteros (# # # #) por fila de tu matriz A \n");
    for(int i = 0; i < 4; ++i){
        printf("Fila %d: ", i+1);
        scanf("%d %d %d %d", &matrixA[i][0], &matrixA[i][1], &matrixA[i][2], &matrixA[i][3]);
    }
    printf("Escribe 4 enteros (# # # #) por fila de tu matriz B \n");
    for(int i = 0; i < 4; ++i){
        printf("Fila %d: ", i+1);
        scanf("%d %d %d %d", &matrixB[i][0], &matrixB[i][1], &matrixB[i][2], &matrixB[i][3]);
    }
    prodMatricial(matrixA, matrixB);
    printf("\nMatriz resultante = ");

    for (int i = 0; i < 4; i++) {
        printf("\n { %d, %d, %d, %d }", matrixA[0][i], matrixA[1][i],
               matrixA[2][i], matrixA[3][i]);
    }
    printf("\n");
}

int main() {
    funcA(); // Suma Vectorial
    funcB(); // Producto Escalar
    funcC(); // Producto Cruz
    funcD(); // Producto Matricial

    return 0;
}
