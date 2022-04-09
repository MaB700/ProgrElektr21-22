library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_1_3 is
    port (
        sw : in std_logic_vector (15 downto 0);
        led : out std_logic_vector (1 downto 0) -- led(0) even , led(1) odd
        -- P_EVEN : out std_logic;
        -- P_ODD : out std_logic
    );
end project_1_3;

architecture Behavioral of project_1_3 is
begin
    led(1) <= sw(0) xor sw(1) xor sw(2) xor sw(3) xor sw(4) xor sw(5) xor sw(6) xor sw(7) xor sw(8) xor sw(9) xor sw(10) xor sw(11) xor sw(12) xor sw(13) xor sw(14) xor sw(15);
    led(0) <= not (sw(0) xor sw(1) xor sw(2) xor sw(3) xor sw(4) xor sw(5) xor sw(6) xor sw(7) xor sw(8) xor sw(9) xor sw(10) xor sw(11) xor sw(12) xor sw(13) xor sw(14) xor sw(15));
end Behavioral;