library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_7_1 is
    port (
        CLK : in std_logic;
        RX : in std_logic;
        L2 : out std_logic;
        TX : out std_logic
    );
end project_7_1;

architecture Behavioral of project_7_1 is

begin

    TX <= RX; -- direct forward
    L2 <= RX; -- connection to the logic analyzer

end Behavioral;