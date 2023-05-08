#define MYWAIT 1000000


int main(void)
{
//PORT REGISTERS
volatile unsigned int *GPIOA_MODER = (unsigned int*) (0x40020000 + 0x00);
volatile unsigned int *GPIOA_ODR = (unsigned int*) (0x40020000 + 0x14);
//CLOCK REGISTERS
volatile unsigned int *RCC_AHB1ENR = (unsigned int*) (0x40023800 + 0x30);
//VARIABLES
int i;
//ENABLE PORT CLOCK:
// this ensure that the peripheral is enabled and connected to the AHB1 bus
*RCC_AHB1ENR |= 0x01U;
//CONFIGURE PORT: set MODER[11:10] = 0x1
*GPIOA_MODER = *GPIOA_MODER | 0x400;
//SWITCH ON THE LED: set ODR[5] = 0x1, that is pulls PA5 high
*GPIOA_ODR = *GPIOA_ODR | 0x20;
// Application code (Infinite loop)
while (1)
{
// Add your code here.
*GPIOA_ODR = *GPIOA_ODR ^ 0x20;
for (i=0; i<MYWAIT; i++)
{
}
}
}
