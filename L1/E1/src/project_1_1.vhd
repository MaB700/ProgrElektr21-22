library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_1_1 is
    port (
        sw : in std_logic_vector(15 downto 0); -- use same names as in the constrains file
        led : out std_logic_vector(15 downto 0)
    );
end project_1_1;

architecture behavioral of project_1_1 is
begin
    led(15 downto 0) <= sw(15 downto 0); -- direct connection from sw (input) to led (output)
end behavioral;