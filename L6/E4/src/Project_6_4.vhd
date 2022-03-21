library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity Project_6_4 is
  Port (
    CLK : in std_logic;
    SW : in std_logic_vector(6 downto 0);
    SND : out std_logic      
  );
end Project_6_4;

architecture Behavioral of Project_6_4 is
signal count : integer range 0 to 10e6 := 0;
signal duty : unsigned(6 downto 0) := (others => '0');
begin

pwm : entity work.PWM
    port map (
        CLK => CLK,
        DUTY => SW, --std_logic_vector(duty),
        PWM => SND
    );

--    process (CLK) is
--    begin
--        if rising_edge(CLK) then
--            count <= count + 1;
--            if count = 10e6 then
--                duty <= duty + 1; 
--                count <= 0;
--            end if;
--        end if;
--    end process;
end architecture Behavioral;
