library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_1_4 is
    port (
        sw : in std_logic_vector(2 downto 0); -- sw(0) A sw(1) B sw(2) C_in
        --C_in : in std_logic; -- internal
        led : out std_logic_vector(1 downto 0) -- led(0) S  led(1) C_out
    );
end project_1_4;

architecture Behavioral of project_1_4 is
begin
    led(1) <= (sw(0) and sw(1)) or (sw(0) and sw(2)) or (sw(1) and sw(2)); -- C_out output
    led(0) <= (sw(0) xor sw(1)) xor sw(2); -- S output
end Behavioral;