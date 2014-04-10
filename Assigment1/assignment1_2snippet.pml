bool turn, flag[2];
byte ncrit; //number of processes in the critical section

active [2] proctype user() {
  assert _pid == 0 || _pid == 1; //_pid is predeclared in spin, to be id of current process, starting from zero.
  again:
  flag[_pid] = 1; //set flag for current process
  turn = _pid; //request turn for current process
  flag[1 - _pid] == 0 || turn == 1 - _pid; //wait for the other process to complete critical, or the other to request a turn 
  ncrit++;
  assert ncrit == 1; //assert only one process is in the critical section.
  ncrit--;
  flag[_pid] = 0; //unset flag for current process
  goto again //do loop again
}
