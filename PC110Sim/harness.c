
#include <stdio.h>
#include "PC110Core/PC110Core.h"
int main(){
 PC110Machine*m=pc110_create(); pc110_load_bios(m,"Roms/pc110_bios.bin");
 pc110_cpu_step(m,50000);
 char st[4096]; pc110_cpu_format_state(m,st,sizeof st); puts(st);
 char tr[1048576]; pc110_trace_copy(m,tr,sizeof tr);
 // print tail
 int n=0; while(tr[n]) n++;
 int start=n>4000?n-4000:0; puts(tr+start);
 return 0;
}
