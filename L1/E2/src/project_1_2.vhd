library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_1_2 is
    port (
        sw : in std_logic_vector(5 downto 0); -- I named sw instead
        led : out std_logic_vector(0 downto 0) -- O named led instead
    --  led : out std_logic  -- another option, note: need to change "{led[0]}" to "led" in the constrains file    
    );
end project_1_2;

architecture Behavioral of project_1_2 is
begin
    led(0) <= (sw(5) and sw(2)) or (sw(4) and sw(1)) or (sw(3) and sw(0)); -- logic funtion of choice
end Behavioral;