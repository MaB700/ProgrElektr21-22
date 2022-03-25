library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
    Port ( 
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
    generic map (
        FREQ_IN => 100e6,
        FREQ_OUT => 100
    )
    port map (
        CLK => CLK,
        T => timer_T
    );
    
    process (CLK) begin
        if rising_edge(CLK) then
            edge_out <= '0';
            if timer_T = '1' then
                --if I = '0' then
                    --was_zero <= '1';
                --else
                    was_zero <= I;
                --end if;
                
                if I = '1' and was_zero = '0' then
                    edge_out <= '1';
                end if;
                
            end if;
        end if;
    end process;
EDGE <= edge_out;
end Behavioral;
