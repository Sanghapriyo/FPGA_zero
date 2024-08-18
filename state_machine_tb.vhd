library ieee;
use ieee.std_logic_1164.all;

entity state_machine_tb is 
end state_machine_tb;

architecture arch of state_machine_tb is
    constant CLOCK_PERIOD: time := 10 ns;
    signal clk: std_logic := '0';
    signal rst: std_logic := '1';
    signal sIDLE, s1, s2, s3: std_logic;
begin
    state_machine_inst: entity work.state_machine
        port map (
            clk   => clk,
            rst   => rst,
            sIDLE => sIDLE,
            s1    => s1,
            s2    => s2,
            s3    => s3 );
            
    process
    begin
        while now < 1500 ns loop  
            clk <= '0';
            wait for CLOCK_PERIOD / 2;
            clk <= '1';
            wait for CLOCK_PERIOD / 2;
        end loop;
        wait;
    end process;
    
    process
    begin
        rst <= '1';
        wait for CLOCK_PERIOD * 10;
        rst <= '0';
        wait for 400 ns;
        
        rst <= '1';
        wait for CLOCK_PERIOD * 10;
        rst <= '0';
        wait;
    end process;
end architecture arch;