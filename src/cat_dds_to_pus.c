/** ********************************************
 @file cat_dds_to_pus.c
 @brief convert dds file to ccsds pus file
 from an original program by Jouni Ryno
 Jouni.Ryno@fmi.fi
 @author Francesco Lazzarotto francesco.lazzarotto@inaf.it
 @copyright 2019 GPL 3 free software license
***********************************************/

#include <stdio.h>
#include <stdlib.h>
#include <sys_types.h>
#include <sys_stat.h>
#include <fcntl.h>
#include <endian.h>
#define _DEFAULT_SOURCE
#define _POSIX_C_SOURCE
int main(int argc, char **argv)
{
  int fd; /* pointer to input file */
	/**  @var dds_head[18] 
	/**  @brief bytes array saving dds header */
  char dds_head[18]; /**< dds_head Detailed description after the member */
  char dds_packet[4096]; /**< dds_packet Detailed description after the member */
  int *len;
  int res;

  fd = open(argv[1], O_RDONLY);
  if (fd > 0) {
    do {
      res = read(fd, dds_head, 18);
      if (res) {
        len = (int *)&(dds_head[8]);
        /* fprintf(stderr, "len %i %8.8X\n", be32toh(*len), *len); */
        read(fd, dds_packet, be32toh(*len));
        write(1, dds_packet, be32toh(*len));
      }
    } while (res > 0);
  } else {
  }
  return 0;
}

