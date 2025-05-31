%let pgm=utl-swap-first-and-last-records-using-an-interesting-do-loop;

%stop_submission;

Swap first and last records using an interesting do loop

            last    middle         first
  do recnum=nobs,   2 to Nobs-1,   1

Solution by
Bartosz Jablonski
yabwon@gmail.com

github
https://tinyurl.com/2hxfz87f
https://github.com/rogerjdeangelis/utl-swap-first-and-last-records-using-an-interesting-do-loop

communities.sas
https://tinyurl.com/4vjrbruc
https://communities.sas.com/t5/SAS-Programming/How-to-Swap-first-and-last-record-using-Temporary-Arrays/m-p/777593#M247409

/***********************************************************************************/
/*          INPUT        |          PROCESS                      |    OUTPUT       */
/*          =====        |          =======                      |    ======       */
/* WORK.HAVE total obs=5 | data want;                            | WORK.WANT obs=5 */
/*                       |    do point=nobs,2 to nobs-1,1;       |                 */
/* Obs    NUM            |      set have point=point nobs=nobs;  | Obs    NUM      */
/*                       |      output;                          |                 */
/*  1      12            |    end;                               |  1      24      */
/*  2      35            |  stop;                                |  2      35      */
/*  3       9            |  run;                                 |  3       9      */
/*  4      56            |  proc print;                          |  4      56      */
/*  5      24            |  run;                                 |  5      12      */
/***********************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
