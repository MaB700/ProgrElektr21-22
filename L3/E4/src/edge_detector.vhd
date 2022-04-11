library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity edge_detector is
    port (
        CLK : in std_logic;
        I : in std_logic;
        EDGE : out std_logic
    );
end edge_detector;

architecture Behavioral of edge_detector is
    signal edge_out : std_logic := '0';
    signal was_zero : std_logic := '0';
    signal timer_T : std_logic;
begin
    freq_changer : entity work.project_3_1
        generic map(
            FREQ_IN => 100e6,
            FREQ_OUT => 100 -- 100Hz to eliminate bouncing effect
        )
        port map(
            CLK => CLK,
            T => timer_T
        );

    process (CLK) begin
        if rising_edge(CLK) then
            edge_out <= '0'; -- (*)
            if timer_T = '1' then -- 
                was_zero <= I; -- set I to was_zero, but only in the next CLK cycle because its a signal
                if I = '1' and was_zero = '0' then -- was_zero is I from previous CLK cycle, I is always current
                    edge_out <= '1'; -- goes to '1' for 1 CLK cycle (*)
                end if;
            end if;
        end if;
    end process;
    EDGE <= edge_out;
end Behavioral;