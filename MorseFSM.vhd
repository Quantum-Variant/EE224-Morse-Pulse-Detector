-- include libraries
LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY MorseFSM IS
PORT (
      clock : 	IN STD_LOGIC;
      INPUT :	IN STD_LOGIC;
      OUTPUT:	OUT STD_LOGIC := '0');
END ENTITY;

-- Architecture definition for the MorseFSM entity
ARCHITECTURE RTL OF MorseFSM IS
TYPE State_type IS (O, N, DS, S, DA, L1, L2, L3);  -- Define the states
SIGNAL State : State_Type;    -- Create a signal that uses the different states

BEGIN 

	--Input Process
	PROCESS (clock) 
	BEGIN
	IF rising_edge(clock) THEN    -- if there is a rising edge of the clock, then do the following
 
		-- Based on the value of the state variables and any other control signals, changes to a new state.
		CASE State IS
		
			WHEN O => 
				OUTPUT <= '0';
				
				IF INPUT='1' THEN 
					State <= N;  
					
				ELSIF INPUT='0' then
					
					State <= O;
					
				END IF;
				
			WHEN N => 
				OUTPUT <= '0';
				
				IF INPUT='1' THEN 
					State <= DS;  
					
				ELSIF INPUT='0' THEN
					State <= O;
					
				END IF; 
				
			WHEN DS => 
				OUTPUT<= '0';
				IF INPUT='1' THEN 
					State <= DA;
					
				ELSIF INPUT='0' THEN
					State <= S;
					
				END IF; 
			WHEN S=> 
				OUTPUT  <= '1';
				STATE <= O;
				
			WHEN DA=> 
				OUTPUT <= '1';
				STATE <= L1;
				
			WHEN L1=> 
				OUTPUT <= '1';
				STATE <= L2;
				
			WHEN L2=> 
				OUTPUT <= '1';
				STATE <= L3;
				
			WHEN L3=>
				OUTPUT <= '1';
				STATE <= O;
				
			WHEN OTHERS => -- Invalid state
				OUTPUT <= '0';
				State <= O;
				
		END CASE; 
    END IF; 
	END PROCESS;
	
END RTL;