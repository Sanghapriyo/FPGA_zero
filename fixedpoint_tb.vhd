library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fixedpoint_tb is 
end entity fixedpoint_tb;

architecture arch of fixedpoint_tb is
    constant CLOCK_PERIOD: time := 10 ns;
    signal clk     : std_logic := '0';
    signal rst     : std_logic := '1';
    signal a, b    : signed(15 downto 0);
    signal sum_ab  : signed(16 downto 0);
    signal prod_ab : signed(31 downto 0);

begin
    fixedpoint_inst: entity work.fixedpoint
        port map (
            clk     => clk,
            rst     => rst,
            a       => a,
            b       => b,
            sum_ab  => sum_ab,
            prod_ab => prod_ab );

    process
    begin
        clk <= '0';
        wait for CLOCK_PERIOD / 2;
        clk <= '1';
        wait for CLOCK_PERIOD / 2;
    end process;

    process
    begin
        rst <= '1';
        wait for CLOCK_PERIOD * 10;
        rst <= '0';
        wait;
    end process;

    process
    begin
        -- First input set
        a <= X"A440";  -- -23488
        b <= X"2120";  -- 8480
        wait for CLOCK_PERIOD * 20;
        
        -- Second input set
        a <= X"AC80";  -- -21504
        b <= X"2F80";  -- 12160
        wait;
    end process;
end architecture arch;
