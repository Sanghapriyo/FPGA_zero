library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is 
    port (  
        clk   : in std_logic;
        rst   : in std_logic;
        count : out std_logic_vector(31 downto 0) );
end entity counter;

architecture arch of counter is 
    signal count_int: std_logic_vector(31 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count_int <= X"00000000";
            else
                count_int <= count_int + 1;
            end if;
        end if;
    end process;

    count <= count_int;
end architecture arch;