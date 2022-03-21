library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity project_6_5 is
    Port ( 
        CLK : in std_logic;
        DC : in std_logic_vector(7 downto 0); -- 7 downto 0
        FREQ : in std_logic_vector(13 downto 6);
        SPK : out std_logic
    );
end project_6_5;

architecture Behavioral of project_6_5 is

begin
    
    sound : entity work.PWM
    port map (
        CLK => CLK,
        FREQ(15 downto 14) => "00",
        FREQ(13 downto 6) => FREQ(13 downto 6),
        FREQ(5 downto 0) => "000000",
        DUTY => DC,
        PWM => SPK    
    );

end Behavioral;
