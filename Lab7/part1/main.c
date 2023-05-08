#include <stdint.h>

int main(void)
{
	//PORT REGISTERS
	volatile unsigned int *GPIOA_MODER = (unsigned int*) (0x40020000 + 0x00);
	volatile unsigned int *GPIOC_MODER = (unsigned int*) (0x40020000 + 0x0800 + 0x00);


	volatile unsigned int *GPIOA_ODR = (unsigned int*) (0x40020000 + 0x14);
	volatile unsigned int *GPIOC_IDR = (unsigned int*) (0x40020000 + 0x0800 + 0x10);

	//CLOCK REGISTERS
	volatile unsigned int *RCC_AHB1ENR = (unsigned int*) (0x40023800 + 0x30);

	//VARIABLES

	volatile unsigned int flag = 0x0U;

	//ENABLE PORT CLOCK:
	// this ensure that both the peripherals are enabled and connected to the AHB1 bus
	*RCC_AHB1ENR |= 0x05U;

	//CONFIGURE PORT: set MODER[11:10] = 0x1
	*GPIOA_MODER = *GPIOA_MODER | 0x400;

	//CONFIGURE PORT: set MODER[27:26] = 0x0
	*GPIOC_MODER = *GPIOC_MODER & 0xF3FFFFFF;


	// Application code (Infinite loop)
	while (1) {
		flag = *GPIOC_IDR;
		flag &= 0x2000;
		if (flag == 0x2000) {
			*GPIOA_ODR = *GPIOA_ODR & 0xFFFFFFDF;
		} else {
			*GPIOA_ODR = *GPIOA_ODR | 0x20U;
		}
	}
}