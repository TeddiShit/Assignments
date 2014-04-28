chan request = [0] of { chan, byte };

active [2] proctype Server() {
  byte client;
  chan replych;
  end:
  do
  :: request ? replych,client -> 
		replych ! client, _pid		//answer using the client's local channel
  od
}

active [3] proctype Client() {
  byte client, server;
  chan replych = [0] of { byte, byte }; //create local channel
  request ! replych, _pid;
  replych ? client, server;
  assert client == _pid;
}
