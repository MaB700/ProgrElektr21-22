library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity project_3_3 is
    port (
        CLK : in std_logic;
        C : out std_logic_vector (7 downto 0);
        A : out std_logic_vector (3 downto 0)
    );

end project_3_3;

architecture Behavioral of project_3_3 is
    signal timer_T : std_logic;
    signal counter : unsigned(13 downto 0) := (others => '0');
begin
        
    timer : entity work.project_3_1
        generic map(
            FREQ_IN => 100e6,
            FREQ_OUT => 100 -- (*)
        )
        port map(
            CLK => CLK,
            T => timer_T
        );
    
    display : entity work.display_wrapper
        port map(
            CLK => CLK,
            BINARY => std_logic_vector(counter), -- type conversion, unsigned -> std_logic_vector
            SEG => C(6 downto 0),
            DP => C(7),
            AN => A
        );
       
    process (CLK) begin
        if rising_edge(CLK) then
            if timer_T = '1' then -- run the counter up at a 100Hz rate (*)
                counter <= counter + 1; -- overflows eventually
            end if;
        end if;
    end process;    

end Behavioral;