-- HSPG.vhd (hobby servo pulse generator)
-- This starting point generates a pulse between 100 us and something much longer than 2.5 ms.

library IEEE;
library lpm;

use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use lpm.lpm_components.all;

entity HSPG is
    port(
        IO_WRITE    : in  std_logic;
        IO_DATA     : in  std_logic_vector(15 downto 0);
        CLOCK       : in  std_logic;
        RESETN      : in  std_logic;
		  CS1			  : in  std_logic;
		  CS2			  : in  std_logic;
		  CS3			  : in  std_logic;
		  CS4			  : in  std_logic;
		  SPEED		  : in  std_logic;
        PULSE       : out std_logic;
		  PULSE2      : out std_logic;
		  PULSE3		  : out std_logic;
		  PULSE4		  : out std_logic
    );
end HSPG;

architecture a of HSPG is

    signal command : std_logic_vector(15 downto 0);  -- command sent from SCOMP
	 signal command2 : std_logic_vector(15 downto 0);  -- command sent from SCOMP
	 signal command3 : std_logic_vector(15 downto 0); -- command sent from SCOMP
	 signal command4 : std_logic_vector(15 downto 0); -- command sent from SCOMP
	 
	 signal s : std_logic_vector(15 downto 0) := x"07c6"; -- speed sent from SCOMP
	 
    signal count   : std_logic_vector(15 downto 0);  -- internal counter
	 signal count2   : std_logic_vector(15 downto 0);  -- internal counter
	 signal count3   : std_logic_vector(15 downto 0);  -- internal counter
	 signal count4   : std_logic_vector(15 downto 0);  -- internal counter
	 
	 signal change  : std_logic := '1';
	 signal change2  : std_logic := '1';
	 signal change3  : std_logic := '1';
	 signal change4  : std_logic := '1';


begin
--------------------------------------------------------------------------------------------------------------------
		-- Latch data on rising edge of CS
			 process (RESETN, CS1) begin
					  if RESETN = '0' then
							command <= x"0000";
					  elsif IO_WRITE = '1' and rising_edge(CS1) and change = '1' then
							command <= IO_DATA; --001 1111 1111					
							if command > x"00b4" then
								command <= x"00b4";
							end if;
					  end if;
				--	  end if;
			 end process;

			 -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
			 -- flexible and it has some issues.  It works, but you need to consider how
			 -- to improve this as part of the project.
			 process (RESETN, CLOCK)begin
				  if (RESETN = '0') then
						count <= x"0000";
						change <= '1';
				  elsif rising_edge(CLOCK) then
						-- Each clock cycle, a counter is incremented.
						count <= count + 1;

						-- When the counter reaches the full desired period, start the period over.
						if count = s then  -- 20 ms has elapsed
							 -- Reset the counter and set the output high.
							 count <= x"0000";
							 PULSE <= '1';
							 change <= '0';
						-- Within the period, when the counter reaches the "command" value, set the output low.
						-- This will make larger command values produce longer pulses.
						elsif count = command + x"003b" then
							 PULSE <= '0';
							 change <= '1';
						end if;
				  end if;
			 end process;

-------------------------------------------------------------------------------------------------------------------------
			 
		-- Latch data on rising edge of CS2
			 process (RESETN, CS2) begin
					  if RESETN = '0' then
							command2 <= x"0000";
					  elsif IO_WRITE = '1' and rising_edge(CS2) and change2 = '1' then
							command2 <= IO_DATA;
							if command2 > x"00b4" then
								command2 <= x"00b4";
							end if;
					  end if;
			 end process;

			 -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
			 -- flexible and it has some issues.  It works, but you need to consider how
			 -- to improve this as part of the project.
			 process (RESETN, CLOCK)begin
				  if (RESETN = '0') then
						count2 <= x"0000";
						change2 <= '1';
				  elsif rising_edge(CLOCK) then
						-- Each clock cycle, a counter is incremented.
						count2 <= count2 + 1;

						-- When the counter reaches the full desired period, start the period over.
						if count2 = x"07c6" then  -- 20 ms has elapsed
							 -- Reset the counter and set the output high.
							 count2 <= x"0000";
							 PULSE2 <= '1';
							 change2 <= '0';
						-- Within the period, when the counter reaches the "command" value, set the output low.
						-- This will make larger command values produce longer pulses.
						elsif count2 = command2 + x"003b" then
							 PULSE2 <= '0';
							 change2 <= '1';
						end if;
				  end if;
			 end process;

-------------------------------------------------------------------------------------------------------------------------
		-- Latch data on rising edge of CS3
			 process (RESETN, CS3) begin
					  if RESETN = '0' then
							command3 <= x"0000";
					  elsif IO_WRITE = '1' and rising_edge(CS3) and change3 = '1' then
							command3 <= IO_DATA;
							if command3 > x"00b4" then
								command3 <= x"00b4";
							end if;
					  end if;
			 end process;

			 -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
			 -- flexible and it has some issues.  It works, but you need to consider how
			 -- to improve this as part of the project.
			 process (RESETN, CLOCK)begin
				  if (RESETN = '0') then
						count3 <= x"0000";
						change3 <= '1';
				  elsif rising_edge(CLOCK) then
						-- Each clock cycle, a counter is incremented.
						count3 <= count3 + 1;

						-- When the counter reaches the full desired period, start the period over.
						if count3 = x"07c6" then  -- 20 ms has elapsed
							 -- Reset the counter and set the output high.
							 count3 <= x"0000";
							 PULSE3 <= '1';
							 change3 <= '0';
						-- Within the period, when the counter reaches the "command" value, set the output low.
						-- This will make larger command values produce longer pulses.
						elsif count3 = command3 + x"003b" then
							 PULSE3 <= '0';
							 change3 <= '1';
						end if;
				  end if;
			 end process;

-------------------------------------------------------------------------------------------------------------------------
		-- Latch data on rising edge of CS4
			 process (RESETN, CS4) begin
					  if RESETN = '0' then
							command4 <= x"0000";
					  elsif IO_WRITE = '1' and rising_edge(CS4) and change4 = '1' then
							command4 <= IO_DATA;
							if command4 > x"00b4" then
									command4 <= x"00b4";
							end if;
					  end if;
			 end process;

			 -- This is a VERY SIMPLE way to generate a pulse.  This is not particularly
			 -- flexible and it has some issues.  It works, but you need to consider how
			 -- to improve this as part of the project.
			 process (RESETN, CLOCK)begin
				  if (RESETN = '0') then
						count4 <= x"0000";
						change4 <= '1';
				  elsif rising_edge(CLOCK) then
						-- Each clock cycle, a counter is incremented.
						count4 <= count4 + 1;

						-- When the counter reaches the full desired period, start the period over.
						if count4 = x"07c6" then  -- 20 ms has elapsed
							 -- Reset the counter and set the output high.
							 count4 <= x"0000";
							 PULSE4 <= '1';
							 change4 <= '0';
						-- Within the period, when the counter reaches the "command" value, set the output low.
						-- This will make larger command values produce longer pulses.
						elsif count4 = command4 + x"003b" then
							 PULSE4 <= '0';
							 change4 <= '1';
						end if;
				  end if;
			 end process;

-------------------------------------------------------------------------------------------------------------------------
			
			process (RESETN, SPEED) begin
					  if RESETN = '0' then
							s <= x"07c6";
					  elsif IO_WRITE = '1' and rising_edge(SPEED) then
							s <= IO_DATA;
							if s(1 downto 0) = "00" then
								s <= x"03e3";  -- faster (*2)
							elsif s(1 downto 0) = "01" then
								s <= x"07c6"; --default
							elsif s(1 downto 0) = "10" then
								s <= x"0ba9"; -- slower (*1.5)
							else
								s <= x"0f8c"; --slowest (*2)
							end if;
					  end if;
			 end process;
end a;