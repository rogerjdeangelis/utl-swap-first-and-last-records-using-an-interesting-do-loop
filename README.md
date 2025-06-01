# utl-swap-first-and-last-records-using-an-interesting-do-loop
Swap first and last records using an interesting do loop
      %let pgm=utl-swap-first-and-last-records-using-an-interesting-do-loop;

    %stop_submission;

    Swap first and last records using an interesting do loop

                last    middle         first
      do recnum=nobs,   2 to Nobs-1,   1

    Multiple collabarations

     Four Solutions
          1 sas do loop
            Bartosz Jablonski
            yabwon@gmail.com

          2 sas if then
            Keintz, Mark
            mkeintz@outlook.com

          3 sas sql

          4 r sql
            for python and excel see
            https://tinyurl.com/4e6yaap8

          5 why monotonic() is safe in sas?
            and rowid is safe in r sqldf?
            be skeptical?
            We need to know wht is keeping
            this undocumented function?

    github
    https://tinyurl.com/2hxfz87f
    https://github.com/rogerjdeangelis/utl-swap-first-and-last-records-using-an-interesting-do-loop

    communities.sas
    https://tinyurl.com/4vjrbruc
    https://communities.sas.com/t5/SAS-Programming/How-to-Swap-first-and-last-record-using-Temporary-Arrays/m-p/777593#M247409

    /***********************************************************************************/
    /*          INPUT        |          PROCESS                      |    OUTPUT       */
    /*          =====        |          =======                      |    ======       */
    /* WORK.HAVE total obs=5 | 1 SAS DO LOOP                         |                 */
    /*                       | =============                         |                 */
    /* Obs    NUM            |                                       |                 */
    /*                       | data want;                            | WORK.WANT obs=5 */
    /*  1      12            |    do point=nobs,2 to nobs-1,1;       |                 */
    /*  2      35            |      set have point=point nobs=nobs;  | Obs    NUM      */
    /*  3       9            |      output;                          |                 */
    /*  4      56            |    end;                               |  1      24      */
    /*  5      24            |  stop;                                |  2      35      */
    /*                       |  run;                                 |  3       9      */
    /* data have;            |  proc print;                          |  4      56      */
    /* input Num @@;         |  run;                                 |  5      12      */
    /* cards4;               |                                       |                 */
    /* 12 35 9 56 24         |----------------------------------------                 */
    /* ;;;;                  | 2 SAS IF THEN                         |                 */
    /* run;quit;             | =============                         |                 */
    /*                       |                                       |                 */
    /*                       | data want;                            |                 */
    /*                       |                                       |                 */
    /*                       |  if _n_=1 then                        |                 */
    /*                       |     set have point=nrecs nobs=nrecs;  |                 */
    /*                       |  else if _n_<nrecs then               |                 */
    /*                       |    set have (firstobs=2);             |                 */
    /*                       |  else set have (obs=1);               |                 */
    /*                       |                                       |                 */
    /*                       | run;                                  |                 */
    /*                       |                                       |                 */
    /*                       |---------------------------------------|                 */
    /*                       | 3 SAS SQL                             |                 */
    /*                       | =========                             |                 */
    /*                       |                                       |                 */
    /*                       | proc sql _method  ;                   |                 */
    /*                       |   create                              |                 */
    /*                       |     table tmp as                      |                 */
    /*                       |   select                              |                 */
    /*                       |                                       |                 */
    /*                       |   /*--- should be safe here or        |                 */
    /*                       |      why would sas provide            |                 */
    /*                       |      monotonic().                     |                 */
    /*                       |      It can not  be dsfe here?        |                 */
    /*                       |   ----*/                              |                 */
    /*                       |     monotonic() as rowNum             |                 */
    /*                       |    ,num                               |                 */
    /*                       |   from                                |                 */
    /*                       |     have                              |                 */
    /*                       | ;quit;                                |                 */
    /*                       |                                       |                 */
    /*                       | %let obs= &sqlobs;                    |                 */
    /*                       |                                       |                 */
    /*                       | proc sql;                             |                 */
    /*                       |   create                              |                 */
    /*                       |      table want as                    |                 */
    /*                       |   select                              |                 */
    /*                       |      num                              |                 */
    /*                       |   from                                |                 */
    /*                       |      tmp                              |                 */
    /*                       |   where                               |                 */
    /*                       |      rowNum=&obs                      |                 */
    /*                       |   union                               |                 */
    /*                       |      all                              |                 */
    /*                       |   select                              |                 */
    /*                       |      num                              |                 */
    /*                       |   from                                |                 */
    /*                       |      tmp                              |                 */
    /*                       |   where                               |                 */
    /*                       |      1 < rowNum < &obs                |                 */
    /*                       |   union                               |                 */
    /*                       |      all                              |                 */
    /*                       |   select                              |                 */
    /*                       |      num                              |                 */
    /*                       |   from                                |                 */
    /*                       |      tmp                              |                 */
    /*                       |   where                               |                 */
    /*                       |      rowNum=1                         |                 */
    /*                       | ;quit;                                |                 */
    /*                       |                                       |                 */
    /*                       | proc print data=sd1.want;             |                 */
    /*                       | run;quit;                             |                 */
    /*                       |                                       |                 */
    /*                       |----------------------------------------                 */
    /*                       | 4 SAS SQL                             |                 */
    /*                       | ========                              |                 */
    /*                       |                                       |                 */
    /*                       | %utl_rbeginx;                         |                 */
    /*                       | parmcards4;                           |                 */
    /*                       | library(haven)                        |                 */
    /*                       | library(sqldf)                        |                 */
    /*                       | source("c:/oto/fn_tosas9x.R")         |                 */
    /*                       | options(sqldf.dll                     |                 */
    /*                       |  = "d:/dll/sqlean.dll")               |                 */
    /*                       | have<-read_sas(                       |                 */
    /*                       |  "d:/sd1/have.sas7bdat")              |                 */
    /*                       | print(have)                           |                 */
    /*                       | want<-sqldf('                         |                 */
    /*                       | with                                  |                 */
    /*                       |   tmp  as (                           |                 */
    /*                       | select                                |                 */
    /*                       |   rowid as rowNum                     |                 */
    /*                       |  ,num                                 |                 */
    /*                       | from                                  |                 */
    /*                       |   have                                |                 */
    /*                       | )                                     |                 */
    /*                       |   select                              |                 */
    /*                       |    num                                |                 */
    /*                       | from                                  |                 */
    /*                       |    tmp                                |                 */
    /*                       | where                                 |                 */
    /*                       |    rowNum=&obs                        |                 */
    /*                       | union                                 |                 */
    /*                       |    all                                |                 */
    /*                       | select                                |                 */
    /*                       |    num                                |                 */
    /*                       | from                                  |                 */
    /*                       |    tmp                                |                 */
    /*                       | where                                 |                 */
    /*                       |    1 < rowNum < &obs                  |                 */
    /*                       | union                                 |                 */
    /*                       |    all                                |                 */
    /*                       | select                                |                 */
    /*                       |    num                                |                 */
    /*                       | from                                  |                 */
    /*                       |    tmp                                |                 */
    /*                       | where                                 |                 */
    /*                       |    rowNum=1                           |                 */
    /*                       | ')                                    |                 */
    /*                       | want                                  |                 */
    /*                       | fn_tosas9x(                           |                 */
    /*                       |       inp    = want                   |                 */
    /*                       |      ,outlib ="d:/sd1/"               |                 */
    /*                       |      ,outdsn ="want"                  |                 */
    /*                       |      )                                |                 */
    /*                       | ;;;;                                  |                 */
    /*                       | %utl_rendx;                           |                 */
    /*                       |                                       |                 */
    /*                       | proc print data=sd1.want;             |                 */
    /*                       | run;quit;                             |                 */
    /*                       |                                       |                 */
    /*                       |----------------------------------------                 */
    /*                       | 5 SEE BELOW JUSTIFICATION MONOTONIC   |                 */
    /*                       |                                       |                 */
    /***********************************************************************************/

    /*___             _                                        _              _                   __
    | ___|  __      _| |__  _   _  _ __ ___   ___  _ __   ___ | |_ ___  _ __ (_) ___   ___  __ _ / _| ___
    |___ \  \ \ /\ / / `_ \| | | || `_ ` _ \ / _ \| `_ \ / _ \| __/ _ \| `_ \| |/ __| / __|/ _` | |_ / _ \
     ___) |  \ V  V /| | | | |_| || | | | | | (_) | | | | (_) | || (_) | | | | | (__  \__ \ (_| |  _|  __/
    |____/    \_/\_/ |_| |_|\__, ||_| |_| |_|\___/|_| |_|\___/ \__\___/|_| |_|_|\___| |___/\__,_|_|  \___|
                            |___/
     ___  __ _ ___
    / __|/ _` / __|
    \__ \ (_| \__ \
    |___/\__,_|___/

    */

    SOAPBOX ON

    Best Practice:

    For simple, single-table queries in a standard SAS environment,
    MONOTONIC() is generally considered safe for generating row numbers,
    but you should be aware of its unofficial status and test your code thoroughly.
    Why would sas provide a monotonic function if it
    was not safe in this minimal case.


    Note the only monotonic code used in my sqlpartition macro is

      (select
            *
            ,monotonic() as seq
         from
             _have_)

    I wish sas would elaborate on using the above?

    I tested the result above with 10 and 500,000,000 observation
    with and without grouping.

    and sas used the same plan

    sqxfil (applies a where clase but there is no where clause, so where not applied)
        sqxsrc( WORK.HAVEX ) (get rows form single table have)

    Tree as planned.
                                   /-SYM-A-(row_num:1 flag=00000031)
                         /-OBJ----|
                        |          \-SYM-V-(havex.NUM:2 flag=00000001)
               /-FIL----|
              |         |                    /-SYM-V-(havex.NUM:2 flag=00040001)
              |         |          /-OBJ----|
              |         |--SRC----|
              |         |          \-TABL[WORK].havex opt=''
              |         |--empty-
              |         |--empty-
              |         |--empty-
              |         |--empty-
              |         |                    /-SYM-A-(row_num:1 flag=00000031)
              |         |          /-ASGN---|
              |         |         |         |          /-SYM-F-(MONOTONIC:1)
              |         |         |          \-FLST---|
              |          \-OBJE---|
     --SSEL---|


    This is the order of execution

    Reading from the WORK.have table

    assign row numbers (MONOTONIC function)

    No filtering or processing of the data

    Selecting specific columns (NUM and row_num)



    I have tested it with large _have_ tables with
    odvious grouped data(not sorted) and sorted data.
    I does not work with consistently when creating a view or
    embedded view. Sas seems to execute monotnic at different
    times base on the optimizer.
    I have expermented with the sql _tree _method and magic options.
    On the query above sas seems to use

    HOWEVER

    Avoid using MONOTONIC() in production code or in any context
    where result stability and long-term support are required.
    For more robust solutions, consider using a DATA step with
    the automatic variable _N_ for row numbering.

    /*         _     _  __
     ___  __ _| | __| |/ _|
    / __|/ _` | |/ _` | |_
    \__ \ (_| | | (_| |  _|
    |___/\__, |_|\__,_|_|
            |_|
    */

    Rowid is the internal row numbering in sqlite.
    It is initially created from the input r dataframe.
    As with sas use it with a simple query and
    use it once as the first sql query.

    SOAPBOX OFF

    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */

