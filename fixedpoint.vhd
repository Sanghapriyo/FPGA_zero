--two's complement fixed-point arithematic
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fixedpoint is 
    port (
        clk    : in std_logic;
        rst    : in std_logic;
        a      : in signed(15 downto 0);
        b      : in signed(15 downto 0);
        sum_ab : out signed(16 downto 0);
        prod_ab: out signed(31 downto 0) );
end entity fixedpoint;

architecture arch of fixedpoint is
begin 
    process(clk)
    begin
        if rising_edge(clk) then 
            if rst = '1' then 
                sum_ab <= (others => '0');
                prod_ab <= (others => '0');
            else
                sum_ab  <= (a(15) & a) + (b(15) & b);
                prod_ab <= a * b;
            end if;
        end if;
    end process;
end architecture arch;