library IEEE;
use IEEE.std_logic_1164.all;
--use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use WORK.all;

entity registerfile_generic is
    generic(NBIT_DATA: natural := 64; NBIT_ADD: natural := 5);
    port( 
		CLK: 		IN std_logic;
        RESET: 	    IN std_logic;
        ENABLE: 	IN std_logic;
        RD1: 		IN std_logic;
        RD2: 		IN std_logic;
        WR: 		IN std_logic;
        ADD_WR: 	IN std_logic_vector(NBIT_ADD - 1 downto 0);
        ADD_RD1: 	IN std_logic_vector(NBIT_ADD - 1 downto 0);
        ADD_RD2: 	IN std_logic_vector(NBIT_ADD - 1 downto 0);
        DATAIN: 	IN std_logic_vector(NBIT_DATA- 1 downto 0);
        OUT1: 		OUT std_logic_vector(NBIT_DATA - 1 downto 0);
	    OUT2: 		OUT std_logic_vector(NBIT_DATA - 1 downto 0)
    );
end registerfile_generic;

architecture behavioural of registerfile_generic is

    -- suggested structures
    subtype REG_ADDR is natural range 0 to ((2**NBIT_ADD) - 1); -- using natural type
	type REG_ARRAY is array(REG_ADDR) of std_logic_vector(NBIT_DATA - 1 downto 0); 
	signal REGISTERS : REG_ARRAY; 
	
begin 

    process(CLK)
    begin
        -- Default value for output 
        if (rising_edge(CLK)) then
            OUT1 <= (OTHERS => '0');
            OUT2 <= (OTHERS => '0');    
            if (RESET = '1') then
                REGISTERS <= (OTHERS => (OTHERS =>'0'));
            elsif (ENABLE = '1') then
                if (WR = '1' and RD1 = '0' and RD2 = '0') then
                    REGISTERS(to_integer(unsigned(ADD_WR))) <= DATAIN; 
                elsif (WR = '0' and RD1 ='1' and RD2 = '0') then
                    OUT1 <= REGISTERS(to_integer(unsigned(ADD_RD1)));
                elsif (WR = '0' and RD1 = '0' and RD2 = '1' ) then
                    OUT2 <= REGISTERS(to_integer(unsigned(ADD_RD2)));
                elsif (WR = '0' and RD1 = '1' and RD2 = '1') then
                    OUT1 <= REGISTERS(to_integer(unsigned(ADD_RD1)));
                    OUT2 <= REGISTERS(to_integer(unsigned(ADD_RD2)));
                elsif (WR = '1' and RD1 = '1' and RD2 = '0') then
                    OUT1 <= REGISTERS(to_integer(unsigned(ADD_RD1)));
                    REGISTERS(to_integer(unsigned(ADD_WR))) <= DATAIN; 
                elsif (WR = '1' and RD1 = '0' and RD2 = '1') then
                    REGISTERS(to_integer(unsigned(ADD_WR))) <= DATAIN; 
                    OUT2 <= REGISTERS(to_integer(unsigned(ADD_RD2)));
                elsif (WR = '1' and RD2 = '1' and RD2 = '1') then
                    OUT1 <= REGISTERS(to_integer(unsigned(ADD_RD1)));
                    OUT2 <= REGISTERS(to_integer(unsigned(ADD_RD2)));
                    REGISTERS(to_integer(unsigned(ADD_WR))) <= DATAIN; 
                end if ;
            end if;
        end if;
    end process;

end behavioural;

-- configuration CFG_RF_BEH of register_file is
--   for A
--   end for;
-- end configuration;
