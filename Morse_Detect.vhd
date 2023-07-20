LIBRARY ieee;
USE ieee.std_logic_1164.all; 

ENTITY Morse_Detect IS
PORT(LED: BUFFER STD_LOGIC;
		clk 		  : 	IN STD_LOGIC;
      inputpulse :	IN STD_LOGIC;
      outputpulse:	BUFFER STD_LOGIC);
END Morse_Detect;

ARCHITECTURE Detect_Pulse OF Morse_Detect IS  
	COMPONENT MorseFSM
   PORT (clock : 	IN STD_LOGIC;
			INPUT :	IN STD_LOGIC;
			OUTPUT:	OUT STD_LOGIC);
	END COMPONENT;
	
	SIGNAL CLK_1HZ : STD_LOGIC;
	SIGNAL CLK_1HZ_COUNTER : NATURAL RANGE 0 TO 4000000;
	
	BEGIN
	
	
	PROCESS(CLK)
	BEGIN
		IF RISING_EDGE(CLK) THEN
		
			LED <= outputpulse;
			
			IF CLK_1HZ_COUNTER < 4000000 THEN
				CLK_1HZ_COUNTER <= CLK_1HZ_COUNTER + 1;
			ELSIF CLK_1HZ_COUNTER = 4000000 THEN
				CLK_1HZ <= NOT CLK_1HZ;
				CLK_1HZ_COUNTER <= 0;
			END IF;
		END IF;
	END PROCESS;
	
	
	
	UUT:  MorseFSM
      PORT MAP (clock => CLK_1HZ, INPUT => inputpulse, OUTPUT => outputpulse);

END Detect_Pulse;