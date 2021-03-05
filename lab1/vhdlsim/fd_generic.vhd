library IEEE;
use IEEE.std_logic_1164.all; 
use WORK.constants.all;

entity FD_GENERIC is
	generic (NBIT : integer := NumBit);
	Port (	D:	In	std_logic_vector(NBIT-1 downto 0);
		CK:	In	std_logic;
		RESET:	In	std_logic;
		Q:	Out	std_logic_vector(NBIT-1 downto 0));
end FD_GENERIC;


architecture PIPPO_GENERIC of FD_GENERIC is -- flip flop D with syncronous reset

begin
	PSYNCH: process(CK,RESET)
	begin
	  if CK'event and CK='1' then -- positive edge triggered:
	    if RESET='1' then -- active high reset 
	      Q <= (others => '0'); 
	    else
	      Q <= D; -- input is written on output
	    end if;
	  end if;
	end process;

end PIPPO_GENERIC;

architecture PLUTO_GENERIC of FD_GENERIC is -- flip flop D with asyncronous reset

begin
	
	PASYNCH: process(CK,RESET)
	begin
	  if RESET='1' then
	    Q <= (others => '0');
	  elsif CK'event and CK='1' then -- positive edge triggered:
	    Q <= D; 
	  end if;
	end process;

end PLUTO_GENERIC;


configuration CFG_FD_GEN_PIPPO of FD_GENERIC is
	for PIPPO_GENERIC
	end for;
end CFG_FD_GEN_PIPPO;


configuration CFG_FD_GEN_PLUTO of FD_GENERIC is
	for PLUTO_GENERIC
	end for;
end CFG_FD_GEN_PLUTO;

