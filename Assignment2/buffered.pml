chan bufferIn = [0] of { byte };
chan bufferOut = [0] of { byte };

#define BUFFERSIZE 10
byte buffer[BUFFERSIZE];
byte bufferStart = 0; 	//oldest data
byte bufferEnd = 0; 	//next empty buffer element
byte fillCount = 0;

active proctype Reader() {
	byte data, expectedData = 0;
	do
	:: bufferOut ? data ->
		assert data == expectedData;
		expectedData++;
	od	
}

active proctype Writer() {
	byte nextData = 0;
	do
	:: bufferIn ! nextData ->
		nextData++;
	od
}

active proctype BufferHandlerIn() {
	byte data;
	do
  	::
		bufferIn ? data;			//wait for data from writer
		fillCount < BUFFERSIZE; 	//wait for space in buffer
		 
		buffer[bufferEnd] = data;	//place data in next empty space
		
		bufferEnd = (bufferEnd + 1) % BUFFERSIZE;
		fillCount++;
  	od	
}

active proctype BufferHandlerOut() {
	byte data;
	do
  	::
		fillCount > 0;						//wait for data to be buffered
		bufferOut ! buffer[bufferStart];	//send oldest data	

		bufferStart = (bufferStart + 1) % BUFFERSIZE;		
		fillCount--;		
  	od		
}
