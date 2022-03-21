library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_7_2 is
    Port ( 
        CLK : in std_logic;
        SW : in std_logic_vector(7 downto 0);
        BTN : in std_logic_vector(1 downto 0);
        LED : out std_logic;
        TX : out std_logic
    );
end project_7_2;

architecture Behavioral of project_7_2 is

begin
    
    UART : entity work.UART
    port map (
        CLK => CLK,
        RST => BTN(1),
        SEND => BTN(0),
        DIN => SW,
        IDLE => LED,
        TX => TX    
    );

end Behavioral;
