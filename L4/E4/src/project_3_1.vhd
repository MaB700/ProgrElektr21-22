library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity project_3_1 is
    Generic (
        FREQ_IN : integer := 100e6; -- 100MHz / FREQ_OUT 
        FREQ_OUT : integer := 73e6
    );
    Port ( 
        CLK : in std_logic;
        T   : out std_logic
    );
end project_3_1;

architecture Behavioral of project_3_1 is
    constant WIDTH : integer := integer(ceil(log2(real(FREQ_IN/FREQ_OUT))));
    constant max_val : integer := FREQ_IN/FREQ_OUT;
    signal count : unsigned(WIDTH-1 downto 0);
begin
    process (CLK) is
    begin
        -- counter++ for each rising_edge , counter width based on desired freq
        -- output if coutner overflow
        if rising_edge(CLK) then
            count <= count + 1;
            --if count = 2**WIDTH - 1 then 
            if count = max_val - 1 then
                T <= '1';
            else
                T <= '0';
            end if;
        end if;
    end process;

end Behavioral;
