#include <stdio.h>
#include <unistd.h>
void derry() {
    printf("Annyeong!!!!!\n");
    //getchar();
    asm("mv t6, sp");
    asm("li a0, 0x100000");
    asm("sub sp, sp, a0");
    
    asm("li a0, 0x00");       /* load immediate 0xAB to a0 */
    //asm("li a1, 0x100000"); /* a1 = 0x8000 0000 */
    asm("st a0, 0(t6)");      /* store tag a0 to a1 */
    asm("lt a2, 0(t6)");      /* load tag a1 to a2 */

    asm("li a0, 0x0F");       /* load immediate 0xAB to a0 */
    //asm("li a1, 0x100000"); /* a1 = 0x8000 0000 */
    asm("st a0, 0(t6)");      /* store tag a0 to a1 */
    asm("lt a2, 0(t6)");      /* load tag a1 to a2 */

    asm("mv a0, a2");
    //asm("li a0, 1");
    /* writing to 0x8c3 csr makes qemu to exit */
    asm("csrw 0x8c3, a0");
    //sleep(999999999);
}
int main() {
    /* writing to 0x8c3 csr makes qemu to exit */
    asm("csrw 0x8c3, a0");
    derry();
}
