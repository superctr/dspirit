gcc -o dsseq -g dsseq.c
if %ERRORLEVEL% neq 0 goto error
dsseq -j -f -a -h DSMUSIC.DAT dsmusic_all.txt
dsseq -j -f DSMUSIC.DAT dsmusic.txt
:error
