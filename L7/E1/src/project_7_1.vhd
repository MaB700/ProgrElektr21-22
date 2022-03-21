library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_7_1 is
    Port ( 
        CLK : in std_logic;
        RX : in std_logic;
        L2 : out std_logic;
        TX : out std_logic
    );
end project_7_1;

architecture Behavioral of project_7_1 is

begin
    TX <= RX;
    L2 <= RX;
--    process (CLK) is
--    begin
--        if rising_edge(CLK) then
        
        
--        end if;
--    end process;

end Behavioral;
