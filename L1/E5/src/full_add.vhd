library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_add is
    Port ( 
        A : in std_logic; 
        B : in std_logic; 
        C_in : in std_logic;
        C_out : out std_logic;
        S : out std_logic
    );
end full_add;

architecture Behavioral of full_add is
begin
    C_out <= (A and B) or (A and C_in) or (B and C_in);
    S <= (A xor B) xor C_in;
end Behavioral;

