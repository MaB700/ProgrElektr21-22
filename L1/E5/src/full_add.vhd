library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity full_add is
    port (
        A : in std_logic; -- one input number
        B : in std_logic; -- another input number
        C_in : in std_logic; -- carry over bit from previous full adder or '0' if its the first adder
        C_out : out std_logic; -- carry over bit for the next digit
        S : out std_logic -- sum of A & B
    );
end full_add;

architecture Behavioral of full_add is
begin
    C_out <= (A and B) or (A and C_in) or (B and C_in); -- calculate carry bit for next digit
    S <= (A xor B) xor C_in; -- calculate sum
end Behavioral;