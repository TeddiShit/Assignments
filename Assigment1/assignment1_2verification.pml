#define u0try user0@try
#define u0cs user0@cs
#define u1cs user1@cs

bool turn, flag[2];
byte ncrit; //number of critical sections executed

active proctype user0() {
  assert _pid == 0 || _pid == 1; //_pid is predeclared in spin, to be id of current process, starting from zero.
  again:
  flag[_pid] = 1; //set flag for current process
  turn = _pid; //request turn for current process
  try: flag[1 - _pid] == 0 || turn == 1 - _pid; //wait for the other process to complete critical, or the other to request a turn 
  cs: ncrit++;
  flag[_pid] = 0; //unset flag for current process
  goto again //do loop again
}

active proctype user1() {
  assert _pid == 0 || _pid == 1; //_pid is predeclared in spin, to be id of current process, starting from zero.
  again:
  flag[_pid] = 1; //set flag for current process
  turn = _pid; //request turn for current process
  try: flag[1 - _pid] == 0 || turn == 1 - _pid; //wait for the other process to complete critical, or the other to request a turn 
  cs: ncrit++;
  flag[_pid] = 0; //unset flag for current process
  goto again //do loop again
}

ltl otk {
  [](u0try -> (!u1cs U (u1cs U (!u1cs U u0cs))))
}



