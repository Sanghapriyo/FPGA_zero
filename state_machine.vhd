-- finite state machine
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine is 
    port (
        clk   : in std_logic;
        rst   : in std_logic;
        sIDLE : out std_logic;
        s1    : out std_logic;
        s2    : out std_logic;
        s3    : out std_logic );
end entity state_machine;

architecture arch of state_machine is
    constant TRANSITION_DURATION: unsigned(3 downto 0) := "1001"; -- Binary 9
    type states is (state_sIDLE, state_s1, state_s2, state_s3);
    signal curstate: states := state_sIDLE;
    signal nxtstate: states;
    signal count: unsigned(3 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then 
            if rst = '1' then
                curstate <= state_sIDLE;
            else
                curstate <= nxtstate;
            end if;
        end if;
    end process;
    
    process(curstate, count)
    begin
        nxtstate <= curstate; 
        case curstate is 
            when state_sIDLE =>
                nxtstate <= state_s1;
            when state_s1 =>
                if count = TRANSITION_DURATION then nxtstate <= state_s2;
                end if;
            when state_s2 =>
                if count = TRANSITION_DURATION then nxtstate <= state_s3;
                end if;
            when state_s3 =>
                if count = TRANSITION_DURATION then nxtstate <= state_s1;
                end if;
        end case;
    end process;
    
    process(curstate)
    begin
        sIDLE <= '0';
        s1 <= '0';
        s2 <= '0';
        s3 <= '0';
        case curstate is 
            when state_sIDLE => sIDLE <= '1';
            when state_s1    => s1 <= '1';
            when state_s2    => s2 <= '1';
            when state_s3    => s3 <= '1';
        end case;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                count <= (others => '0');
            elsif curstate /= nxtstate then
                count <= (others => '0');
            elsif count /= TRANSITION_DURATION then
                count <= count + 1;
            end if;
        end if;
    end process;
end architecture arch;